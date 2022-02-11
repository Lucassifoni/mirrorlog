defmodule Mirrorlog.Repo.Migrations.CreateProjects do
  use Ecto.Migration

  def change do
    create table(:projects) do
      add :name, :text
      add :status, :integer
      add :main_picture_id, :integer
      add :date_start, :naive_datetime

      timestamps()
    end

    create table(:projects_pictures) do
      add :project_id, :integer
      add :picture_id, :integer
    end
  end
end
