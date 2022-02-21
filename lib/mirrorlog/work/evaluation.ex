defmodule Mirrorlog.Work.Evaluation do
  use Ecto.Schema
  import Ecto.Changeset

  schema "evaluations" do
    field :iinputs, :map
    field :outputs, :map

    belongs_to :session, Mirrorlog.Work.Session

    timestamps()
  end

  @doc false
  def changeset(evaluation, attrs) do
    evaluation
    |> cast(attrs, [:session_id, :iinputs, :outputs])
    |> validate_required([:session_id, :iinputs, :outputs])
  end
end
