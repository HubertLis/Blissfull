defmodule BlissfullySewn.ProductCatalogTest do
  use BlissfullySewn.DataCase

  alias BlissfullySewn.ProductCatalog

  describe "product_sizes" do
    alias BlissfullySewn.ProductCatalog.ProductSize

    import BlissfullySewn.ProductCatalogFixtures

    @invalid_attrs %{price: nil}

    test "list_product_sizes/0 returns all product_sizes" do
      product_size = product_size_fixture()
      assert ProductCatalog.list_product_sizes() == [product_size]
    end

    test "get_product_size!/1 returns the product_size with given id" do
      product_size = product_size_fixture()
      assert ProductCatalog.get_product_size!(product_size.id) == product_size
    end

    test "create_product_size/1 with valid data creates a product_size" do
      valid_attrs = %{price: "120.5"}

      assert {:ok, %ProductSize{} = product_size} = ProductCatalog.create_product_size(valid_attrs)
      assert product_size.price == Decimal.new("120.5")
    end

    test "create_product_size/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = ProductCatalog.create_product_size(@invalid_attrs)
    end

    test "update_product_size/2 with valid data updates the product_size" do
      product_size = product_size_fixture()
      update_attrs = %{price: "456.7"}

      assert {:ok, %ProductSize{} = product_size} = ProductCatalog.update_product_size(product_size, update_attrs)
      assert product_size.price == Decimal.new("456.7")
    end

    test "update_product_size/2 with invalid data returns error changeset" do
      product_size = product_size_fixture()
      assert {:error, %Ecto.Changeset{}} = ProductCatalog.update_product_size(product_size, @invalid_attrs)
      assert product_size == ProductCatalog.get_product_size!(product_size.id)
    end

    test "delete_product_size/1 deletes the product_size" do
      product_size = product_size_fixture()
      assert {:ok, %ProductSize{}} = ProductCatalog.delete_product_size(product_size)
      assert_raise Ecto.NoResultsError, fn -> ProductCatalog.get_product_size!(product_size.id) end
    end

    test "change_product_size/1 returns a product_size changeset" do
      product_size = product_size_fixture()
      assert %Ecto.Changeset{} = ProductCatalog.change_product_size(product_size)
    end
  end
end
