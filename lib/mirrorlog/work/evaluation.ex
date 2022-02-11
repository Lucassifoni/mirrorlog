defmodule Mirrorlog.Work.Evaluation do
  use Ecto.Schema
  import Ecto.Changeset

  schema "evaluations" do
    field :iinputs, :map
    field :member_id, :integer
    field :outputs, :map
    field :session_id, :integer

    timestamps()
  end

  @doc false
  def changeset(evaluation, attrs) do
    evaluation
    |> cast(attrs, [:member_id, :session_id, :iinputs, :outputs])
    |> validate_required([:member_id, :session_id, :iinputs, :outputs])
  end
end
