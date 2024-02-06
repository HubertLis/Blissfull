defmodule BlissfullySewn.ProductCatalogFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `BlissfullySewn.ProductCatalog` context.
  """

  @doc """
  Generate a product_size.
  """
  def product_size_fixture(attrs \\ %{}) do
    {:ok, product_size} =
      attrs
      |> Enum.into(%{
        price: "120.5"
      })
      |> BlissfullySewn.ProductCatalog.create_product_size()

    product_size
  end
end
