defmodule BlissfullySewn.ProductCatalog.ProductSize do
  use Ecto.Schema
  import Ecto.Changeset

  schema "product_sizes" do
    belongs_to :product, BlissfullySewn.Products.Product, references: :id, primary_key: true
    belongs_to :size, BlissfullySewn.Sizes.Size, references: :id, primary_key: true
    field :price, :decimal

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(product_size, attrs) do
    product_size
    |> cast(attrs, [:price, :product_id, :size_id])
    |> validate_required([:price, :product_id, :size_id])
  end
end
