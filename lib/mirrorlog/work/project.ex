defmodule Mirrorlog.Work.Project do
  use Ecto.Schema
  import Ecto.Changeset

  schema "projects" do
    field :date_start, :naive_datetime
    field :main_picture_id, :integer
    field :member_id, :integer
    field :name, :string
    field :status, :integer

    timestamps()
  end

  @doc false
  def changeset(project, attrs) do
    project
    |> cast(attrs, [:member_id, :name, :status, :main_picture_id, :date_start])
    |> validate_required([:member_id, :name, :status, :main_picture_id, :date_start])
  end
end
