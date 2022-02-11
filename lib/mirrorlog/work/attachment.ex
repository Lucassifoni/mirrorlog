defmodule Mirrorlog.Work.Attachment do
  use Ecto.Schema
  import Ecto.Changeset

  schema "attachments" do
    field :hash, :string
    field :mime, :string
    field :original_filename, :string
    field :storage_path, :string

    timestamps()
  end

  @doc false
  def changeset(attachment, attrs) do
    attachment
    |> cast(attrs, [:hash, :storage_path, :original_filename, :mime])
    |> validate_required([:hash, :storage_path, :original_filename, :mime])
  end
end
