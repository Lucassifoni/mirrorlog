defmodule Mirrorlog.Repo.Migrations.AddProjectIdToSession do
  use Ecto.Migration

  def change do
    alter table(:sessions) do
      add :project_id, :integer
    end
  end
end
