defmodule Mirrorlog.Work do
  @moduledoc """
  The Work context.
  """

  import Ecto.Query, warn: false
  alias Mirrorlog.Repo

  alias Mirrorlog.Work.Project
  alias Mirrorlog.Work.Optic
  alias Mirrorlog.Work.Glass
  alias Mirrorlog.Work.Surface
  alias Mirrorlog.Work.Session

  @doc """
  Returns the list of projects.

  ## Examples

      iex> list_projects()
      [%Project{}, ...]

  """
  def list_projects do
    Repo.all(Project)
  end

  @doc """
  Gets a single project.

  Raises `Ecto.NoResultsError` if the Project does not exist.

  ## Examples

      iex> get_project!(123)
      %Project{}

      iex> get_project!(456)
      ** (Ecto.NoResultsError)

  """
  def get_project!(id), do: Repo.get!(Project, id)

  def get_surface!(id), do: Repo.get!(Surface, id)

  def get_optic!(id), do: Repo.get!(Optic, id)

  @doc """
  Creates a project.

  ## Examples

      iex> create_project(%{field: value})
      {:ok, %Project{}}

      iex> create_project(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_project(attrs \\ %{}) do
    %Project{}
    |> Project.changeset(attrs)
    |> Repo.insert()
  end

  def create_optic(attrs \\ %{}) do
    %Optic{}
    |> Optic.changeset(attrs)
    |> Repo.insert()
  end

  def create_surface(attrs \\ %{}) do
    %Surface{}
    |> Surface.changeset(attrs)
    |> Repo.insert()
  end

  def create_glass(attrs \\ %{}) do
    %Glass{}
    |> Glass.changeset(attrs)
    |> Repo.insert()
  end

  def get_or_create_glass_by_name(name) do
    case (from(g in Glass, where: g.name == ^name) |> Repo.one()) do
      nil -> {:ok, g} = create_glass(%{"name" => name })
             g
      %Glass{} = g -> g
    end
  end

  @doc """
  Updates a project.

  ## Examples

      iex> update_project(project, %{field: new_value})
      {:ok, %Project{}}

      iex> update_project(project, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_project(%Project{} = project, attrs) do
    project
    |> Project.changeset(attrs)
    |> Repo.update()
  end

  def update_session(%Session{} = session, attrs) do
    session
    |> Session.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a project.

  ## Examples

      iex> delete_project(project)
      {:ok, %Project{}}

      iex> delete_project(project)
      {:error, %Ecto.Changeset{}}

  """
  def delete_project(%Project{} = project) do
    Repo.delete(project)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking project changes.

  ## Examples

      iex> change_project(project)
      %Ecto.Changeset{data: %Project{}}

  """
  def change_project(%Project{} = project, attrs \\ %{}) do
    Project.changeset(project, attrs)
  end

  def get_last_session_for_surface(%Surface{} = surface) do
    (from(s in Session, where: s.surface_id == ^(surface.id), order_by: [desc: s.id], limit: 1))
      |> Repo.one()
  end

  def set_next_session_id_to_session(%Session{} = previous_session, %Session{} = next_session) do
    previous_session
    |> update_session(%{
      "next_session_id" => next_session.id
    })
  end

  def create_empty_session_for_surface(%Surface{} = surface) do
    previous_session = get_last_session_for_surface(surface)
    optic = get_optic!(surface.optic_id)

    {:ok, session} = %Session{}
    |> Session.changeset(%{
        "surface_id" => surface.id,
        "project_id" => optic.project_id,
        "previous_session_id" => (if previous_session, do: previous_session.id, else: nil)
    })
    |> Repo.insert()

    case previous_session do
      nil -> {:ok, session}
      ps -> set_next_session_id_to_session(ps, session.id)
        {:ok, session}
    end
  end

  def create_attachment_with_upload(%Plug.Upload{} = upload) do
    uploaded = Mirrorlog.Tasks.Uploads.place_upload(upload)
    {:ok, content} = File.read(uploaded.file_path)
    hash = :crypto.hash(:md5, content) |> Base.encode16

    %Mirrorlog.Work.Attachment{}
      |> Mirrorlog.Work.Attachment.changeset(%{
        "hash" => hash,
        "mime" => upload.content_type,
        "original_filename" => Slug.slugify(upload.filename),
        "storage_path" => uploaded.db_file_path,
      })
      |> Repo.insert()
  end
end
