defmodule BlissfullySewn.Colors.Color do
  use Ecto.Schema
  import Ecto.Changeset

  schema "colors" do
    field :name, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(color, attrs) do
    color
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
