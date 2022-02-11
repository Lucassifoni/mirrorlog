defmodule Mirrorlog.Repo.Migrations.CreateEvaluations do
  use Ecto.Migration

  def change do
    create table(:evaluations) do
      add :member_id, :integer
      add :session_id, :integer
      add :iinputs, :map
      add :outputs, :map

      timestamps()
    end
  end
end
