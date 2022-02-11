defmodule Mirrorlog.Work.Project do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:name, :status, :main_picture_id, :date_start]}
  schema "projects" do
    field :date_start, :naive_datetime
    field :main_picture_id, :integer
    field :name, :string
    field :status, :integer

    timestamps()
  end

  @doc false
  def changeset(project, attrs) do
    project
    |> cast(attrs, [:name, :status, :main_picture_id, :date_start])
    |> validate_required([:name, :status, :date_start])
  end
end
