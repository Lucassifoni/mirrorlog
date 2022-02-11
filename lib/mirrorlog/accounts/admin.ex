defmodule Mirrorlog.Accounts.Admin do
  use Ecto.Schema
  import Ecto.Changeset

  schema "admins" do
    field :member_id, :integer

    timestamps()
  end

  @doc false
  def changeset(admin, attrs) do
    admin
    |> cast(attrs, [:member_id])
    |> validate_required([:member_id])
  end
end
