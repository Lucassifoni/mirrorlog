defmodule Mirrorlog.Work.Project do
  use Ecto.Schema
  import Ecto.Changeset

  schema "projects" do
    field :date_start, :naive_datetime
    field :name, :string
    field :status, :integer

    belongs_to :main_picture, Mirrorlog.Work.Attachment

    has_many :optics, Mirrorlog.Work.Optic
    has_many :tools, Mirrorlog.Work.Tool
    has_many :sessions, Mirrorlog.Work.Session

    timestamps()
  end

  @doc false
  def changeset(project, attrs) do
    project
    |> cast(attrs, [:name, :status, :main_picture_id, :date_start])
    |> validate_required([:name, :status, :date_start])
  end
end
