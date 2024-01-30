defmodule BlissfullySewn.Products.Product do
  use Ecto.Schema
  import Ecto.Changeset

  schema "products" do
    field :name, :string
    belongs_to :size, BlissfullySewn.Sizes.Size
    belongs_to :color, BlissfullySewn.Colors.Color
    belongs_to :category, BlissfullySewn.Categories.Category
    field :price, :decimal
    field :vat, :integer

    timestamps(type: :utc_datetime)
  end

    @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :price, :vat, :color_id, :size_id, :category_id])
    |> validate_required([:name, :price, :vat, :category_id])
  end
end
