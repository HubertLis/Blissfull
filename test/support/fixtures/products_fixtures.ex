defmodule BlissfullySewn.ProductsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `BlissfullySewn.Products` context.
  """

  @doc """
  Generate a product.
  """
  def product_fixture(attrs \\ %{}) do
    {:ok, product} =
      attrs
      |> Enum.into(%{
        color: 42,
        name: "some name",
        price: "120.5",
        size: 42,
        vat: 42
      })
      |> BlissfullySewn.Products.create_product()

    product
  end
end
