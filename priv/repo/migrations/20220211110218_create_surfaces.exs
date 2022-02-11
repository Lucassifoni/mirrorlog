defmodule Mirrorlog.Repo.Migrations.CreateSurfaces do
  use Ecto.Migration

  def change do
    create table(:surfaces) do
      add :optic_id, :integer
      add :type, :integer
      add :radius, :float
      add :conic, :float
      add :status, :integer
      add :date_start, :naive_datetime
      add :date_end, :naive_datetime

      timestamps()
    end
  end
end
