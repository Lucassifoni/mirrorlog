defmodule Mirrorlog.Work.Glass do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:name]}
  schema "glasses" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(glass, attrs) do
    glass
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
