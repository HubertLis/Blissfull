defmodule BlissfullySewn.SizesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `BlissfullySewn.Sizes` context.
  """

  @doc """
  Generate a size.
  """
  def size_fixture(attrs \\ %{}) do
    {:ok, size} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> BlissfullySewn.Sizes.create_size()

    size
  end
end
