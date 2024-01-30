defmodule BlissfullySewn.Vat.Tariff do
  use Ecto.Schema
  import Ecto.Changeset

  schema "vats" do
    field :vat, :decimal

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(tariff, attrs) do
    tariff
    |> cast(attrs, [:vat])
    |> validate_required([:vat])
  end
end
