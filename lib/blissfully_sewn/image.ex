defmodule BlissfullySewn.Image do
  use Ecto.Schema
  import Ecto.Changeset

  schema "images" do
    field :url, :string
    belongs_to :product, BlissfullySewn.Products.Product

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(image, attrs) do
    image
    |> cast(attrs, [:url, :product_id])
    |> validate_required([:url, :product_id])
  end
end
