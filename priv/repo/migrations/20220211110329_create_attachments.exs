defmodule Mirrorlog.Repo.Migrations.CreateAttachments do
  use Ecto.Migration

  def change do
    create table(:attachments) do
      add :hash, :text
      add :storage_path, :text
      add :original_filename, :text
      add :mime, :text

      timestamps()
    end
  end
end
