defmodule BlissfullySewn.Products.Product do
  use Ecto.Schema
  import Ecto.Changeset

  schema "products" do
    field :name, :string
    field :size_id, :integer
    belongs_to :color, BlissfullySewn.Colors.Color
    field :price, :decimal
    field :vat, :integer

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :price, :vat, :color_id, :size_id])
    |> validate_required([:name, :price, :vat, :color_id, :size_id])
  end
end
