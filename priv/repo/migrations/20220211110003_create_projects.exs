defmodule Mirrorlog.Repo.Migrations.CreateProjects do
  use Ecto.Migration

  def change do
    create table(:projects) do
      add :member_id, :integer
      add :name, :text
      add :status, :integer
      add :main_picture_id, :integer
      add :date_start, :naive_datetime

      timestamps()
    end
  end
end
