defmodule Mirrorlog.Work.Optic do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:id, :project_id, :surfaces, :type, :name, :glass_id, :status, :diameter, :thickness, :date_start, :date_end]}
  schema "optics" do
    field :date_end, :naive_datetime
    field :date_start, :naive_datetime
    field :diameter, :float
    field :name, :string
    field :status, :integer
    field :thickness, :float
    field :type, :integer

    has_many :surfaces, Mirrorlog.Work.Surface
    belongs_to :glass, Mirrorlog.Work.Glass
    belongs_to :project, Mirrorlog.Work.Project

    timestamps()
  end

  @doc false
  def changeset(optic, attrs) do
    optic
    |> cast(attrs, [:project_id, :type, :name, :glass_id, :status, :diameter, :thickness, :date_start, :date_end])
    |> validate_required([:project_id, :type, :name, :glass_id, :diameter, :thickness])
  end
end
