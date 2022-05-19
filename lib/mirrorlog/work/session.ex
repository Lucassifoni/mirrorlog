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
    field :outcome, :string
    field :short_note, :string
    field :start_conic, :float
    field :start_pv, :float
    field :start_roc, :float
    field :type, :integer

    belongs_to :tool, Mirrorlog.Work.Tool
    belongs_to :project, Mirrorlog.Work.Project
    belongs_to :surface, Mirrorlog.Work.Surface
    belongs_to :previous_session, Mirrorlog.Work.Session
    belongs_to :next_session, Mirrorlog.Work.Session
    belongs_to :stroke, Mirrorlog.Work.Stroke

    timestamps()
  end

  @doc false
  def changeset(session, attrs) do
    session
    |> cast(attrs, [:surface_id, :project_id, :previous_session_id, :next_session_id, :stroke_id, :type, :tool_id, :comments, :goal, :start_roc, :end_roc, :start_conic, :end_conic, :start_pv, :end_pv, :outcome, :date_start, :short_note, :duration, :efficiency])
    |> validate_required([:surface_id, :project_id])
  end
end
