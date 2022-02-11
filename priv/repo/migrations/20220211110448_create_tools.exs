defmodule Mirrorlog.Repo.Migrations.CreateTools do
  use Ecto.Migration

  def change do
    create table(:tools) do
      add :project_id, :integer
      add :member_id, :integer
      add :diameter, :float
      add :thickness, :float
      add :radius, :float
      add :type, :integer
      add :picture_id, :integer
      add :comments, :text
      add :short_note, :text

      timestamps()
    end
  end
end
