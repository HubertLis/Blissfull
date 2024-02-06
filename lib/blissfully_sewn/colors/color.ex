defmodule BlissfullySewn.Colors.Color do
  use Ecto.Schema
  import Ecto.Changeset

  schema "colors" do
    field :name, :string
    many_to_many :products, BlissfullySewn.Products.Product, join_through: "products_colors"
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(color, attrs) do
    color
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
