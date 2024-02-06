defmodule BlissfullySewn.Products.Product do
  use Ecto.Schema
  import Ecto.Changeset

  schema "products" do
    field :name, :string
    belongs_to :size, BlissfullySewn.Sizes.Size
    many_to_many :color, BlissfullySewn.Colors.Color, join_through: "products_colors"
    belongs_to :category, BlissfullySewn.Categories.Category
    field :vat, :decimal
    field :price, :decimal

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :price, :vat, :category_id])
    |> validate_required([:name, :price, :vat, :category_id])
  end
  def update_changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :price, :vat, :category_id])
    |> cast_assoc(:color, with: &color_changeset/2)
    |> cast_assoc(:size, with: &size_changeset/2)
  end
  defp color_changeset(color, color_attrs) do
    color
    |> cast(color_attrs, [:name])
    # ... other validations for colors
  end

  defp size_changeset(size, size_attrs) do
    size
    |> cast(size_attrs, [:name, :price_adjustment])
    # ... other validations for sizes
  end

end
