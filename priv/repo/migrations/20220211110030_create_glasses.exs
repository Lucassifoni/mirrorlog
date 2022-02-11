defmodule Mirrorlog.Repo.Migrations.CreateGlasses do
  use Ecto.Migration

  def change do
    create table(:glasses) do
      add :name, :text

      timestamps()
    end
  end
end
