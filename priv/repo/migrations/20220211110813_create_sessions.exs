defmodule Mirrorlog.Repo.Migrations.CreateSessions do
  use Ecto.Migration

  def change do
    create table(:sessions) do
      add :surface_id, :integer
      add :member_id, :integer
      add :previous_session_id, :integer
      add :next_session_id, :integer
      add :stroke_id, :integer
      add :type, :integer
      add :tool_id, :integer
      add :comments, :text
      add :goal, :text
      add :start_roc, :float
      add :end_roc, :float
      add :start_conic, :float
      add :end_conic, :float
      add :start_pv, :float
      add :end_pv, :float
      add :outcome, :text
      add :date_start, :naive_datetime
      add :short_note, :text
      add :duration, :integer
      add :efficiency, :integer

      timestamps()
    end
  end
end
