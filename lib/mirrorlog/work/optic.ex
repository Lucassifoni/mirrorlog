defmodule Mirrorlog.Work.Optic do
  use Ecto.Schema
  import Ecto.Changeset

  schema "optics" do
    field :date_end, :naive_datetime
    field :date_start, :naive_datetime
    field :diameter, :float
    field :glass_id, :integer
    field :member_id, :integer
    field :name, :string
    field :project_id, :integer
    field :status, :integer
    field :thickness, :float
    field :type, :integer

    timestamps()
  end

  @doc false
  def changeset(optic, attrs) do
    optic
    |> cast(attrs, [:project_id, :member_id, :type, :name, :glass_id, :status, :diameter, :thickness, :date_start, :date_end])
    |> validate_required([:project_id, :member_id, :type, :name, :glass_id, :status, :diameter, :thickness, :date_start, :date_end])
  end
end
