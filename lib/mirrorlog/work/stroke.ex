defmodule Mirrorlog.Work.Stroke do
  use Ecto.Schema
  import Ecto.Changeset

  schema "strokes" do
    field :expression, :string
    field :name, :string
    field :picture_id, :integer
    timestamps()
  end

  @doc false
  def changeset(stroke, attrs) do
    stroke
    |> cast(attrs, [:picture_id, :name, :expression])
    |> validate_required([:picture_id, :name, :expression])
  end
end
