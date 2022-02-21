defmodule Mirrorlog.Work.Tool do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tools" do
    field :comments, :string
    field :diameter, :float
    belongs_to :picture, Mirrorlog.Work.Attachment
    belongs_to :project, Mirrorlog.Work.Project
    field :radius, :float
    field :short_note, :string
    field :thickness, :float
    field :type, :integer

    timestamps()
  end

  @doc false
  def changeset(tool, attrs) do
    tool
    |> cast(attrs, [:project_id, :diameter, :thickness, :radius, :type, :picture_id, :comments, :short_note])
    |> validate_required([:project_id, :diameter, :thickness, :radius, :type, :picture_id, :comments, :short_note])
  end
end
