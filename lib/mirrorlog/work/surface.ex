defmodule Mirrorlog.Work.Surface do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:optic_id, :type, :radius, :conic, :status, :date_start, :date_end]}
  schema "surfaces" do
    field :conic, :float
    field :date_end, :naive_datetime
    field :date_start, :naive_datetime
    field :radius, :float
    field :status, :integer
    field :type, :integer

    belongs_to :optic, Mirrorlog.Work.Optic
    has_many :sessions, Mirrorlog.Work.Session

    timestamps()
  end

  @doc false
  def changeset(surface, attrs) do
    surface
    |> cast(attrs, [:optic_id, :type, :radius, :conic, :status, :date_start, :date_end])
    |> validate_required([:optic_id, :type, :radius, :conic, :status])
  end
end
