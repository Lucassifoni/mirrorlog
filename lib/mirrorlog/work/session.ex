defmodule Mirrorlog.Work.Session do
  use Ecto.Schema
  import Ecto.Changeset

  schema "sessions" do
    field :comments, :string
    field :date_start, :naive_datetime
    field :duration, :integer
    field :efficiency, :integer
    field :end_conic, :float
    field :end_pv, :float
    field :end_roc, :float
    field :goal, :string
    field :next_session_id, :integer
    field :outcome, :string
    field :previous_session_id, :integer
    field :short_note, :string
    field :start_conic, :float
    field :start_pv, :float
    field :start_roc, :float
    field :stroke_id, :integer
    field :surface_id, :integer
    field :tool_id, :integer
    field :type, :integer

    timestamps()
  end

  @doc false
  def changeset(session, attrs) do
    session
    |> cast(attrs, [:surface_id, :previous_session_id, :next_session_id, :stroke_id, :type, :tool_id, :comments, :goal, :start_roc, :end_roc, :start_conic, :end_conic, :start_pv, :end_pv, :outcome, :date_start, :short_note, :duration, :efficiency])
    |> validate_required([:surface_id, :previous_session_id, :next_session_id, :stroke_id, :type, :tool_id, :comments, :goal, :start_roc, :end_roc, :start_conic, :end_conic, :start_pv, :end_pv, :outcome, :date_start, :short_note, :duration, :efficiency])
  end
end
