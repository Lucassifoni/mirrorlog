defmodule Mirrorlog.Work.Tool do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tools" do
    field :comments, :string
    field :diameter, :float
    field :member_id, :integer
    field :picture_id, :integer
    field :project_id, :integer
    field :radius, :float
    field :short_note, :string
    field :thickness, :float
    field :type, :integer

    timestamps()
  end

  @doc false
  def changeset(tool, attrs) do
    tool
    |> cast(attrs, [:project_id, :member_id, :diameter, :thickness, :radius, :type, :picture_id, :comments, :short_note])
    |> validate_required([:project_id, :member_id, :diameter, :thickness, :radius, :type, :picture_id, :comments, :short_note])
  end
end
