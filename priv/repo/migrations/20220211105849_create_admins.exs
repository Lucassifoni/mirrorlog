defmodule Mirrorlog.Repo.Migrations.CreateAdmins do
  use Ecto.Migration

  def change do
    create table(:admins) do
      add :member_id, :integer

      timestamps()
    end
  end
end
