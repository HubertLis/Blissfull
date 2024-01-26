defmodule BlissfullySewn.Products.Product do
  use Ecto.Schema
  import Ecto.Changeset

  schema "products" do
    field :name, :string
    field :size, :integer
    field :color, :integer
    field :price, :decimal
    field :vat, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :price, :vat, :color, :size])
    |> validate_required([:name, :price, :vat, :color, :size])
  end
end
