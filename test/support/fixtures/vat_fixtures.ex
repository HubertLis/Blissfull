defmodule BlissfullySewn.VatFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `BlissfullySewn.Vat` context.
  """

  @doc """
  Generate a tariff.
  """
  def tariff_fixture(attrs \\ %{}) do
    {:ok, tariff} =
      attrs
      |> Enum.into(%{
        vat: "120.5"
      })
      |> BlissfullySewn.Vat.create_tariff()

    tariff
  end
end
