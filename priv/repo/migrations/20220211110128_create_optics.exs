defmodule Mirrorlog.Repo.Migrations.CreateOptics do
  use Ecto.Migration

  def change do
    create table(:optics) do
      add :project_id, :integer
      add :member_id, :integer
      add :type, :integer
      add :name, :text
      add :glass_id, :integer
      add :status, :integer
      add :diameter, :float
      add :thickness, :float
      add :date_start, :naive_datetime
      add :date_end, :naive_datetime

      timestamps()
    end
  end
end
