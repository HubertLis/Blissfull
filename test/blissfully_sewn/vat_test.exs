defmodule BlissfullySewn.VatTest do
  use BlissfullySewn.DataCase

  alias BlissfullySewn.Vat

  describe "vats" do
    alias BlissfullySewn.Vat.Tariff

    import BlissfullySewn.VatFixtures

    @invalid_attrs %{vat: nil}

    test "list_vats/0 returns all vats" do
      tariff = tariff_fixture()
      assert Vat.list_vats() == [tariff]
    end

    test "get_tariff!/1 returns the tariff with given id" do
      tariff = tariff_fixture()
      assert Vat.get_tariff!(tariff.id) == tariff
    end

    test "create_tariff/1 with valid data creates a tariff" do
      valid_attrs = %{vat: "120.5"}

      assert {:ok, %Tariff{} = tariff} = Vat.create_tariff(valid_attrs)
      assert tariff.vat == Decimal.new("120.5")
    end

    test "create_tariff/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Vat.create_tariff(@invalid_attrs)
    end

    test "update_tariff/2 with valid data updates the tariff" do
      tariff = tariff_fixture()
      update_attrs = %{vat: "456.7"}

      assert {:ok, %Tariff{} = tariff} = Vat.update_tariff(tariff, update_attrs)
      assert tariff.vat == Decimal.new("456.7")
    end

    test "update_tariff/2 with invalid data returns error changeset" do
      tariff = tariff_fixture()
      assert {:error, %Ecto.Changeset{}} = Vat.update_tariff(tariff, @invalid_attrs)
      assert tariff == Vat.get_tariff!(tariff.id)
    end

    test "delete_tariff/1 deletes the tariff" do
      tariff = tariff_fixture()
      assert {:ok, %Tariff{}} = Vat.delete_tariff(tariff)
      assert_raise Ecto.NoResultsError, fn -> Vat.get_tariff!(tariff.id) end
    end

    test "change_tariff/1 returns a tariff changeset" do
      tariff = tariff_fixture()
      assert %Ecto.Changeset{} = Vat.change_tariff(tariff)
    end
  end
end
