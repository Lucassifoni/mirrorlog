defmodule Mirrorlog.Repo.Migrations.CreateStrokes do
  use Ecto.Migration

  def change do
    create table(:strokes) do
      add :picture_id, :integer
      add :member_id, :integer
      add :name, :text
      add :expression, :text

      timestamps()
    end
  end
end
