defmodule BlissfullySewn.Vat do
  @moduledoc """
  The Vat context.
  """

  import Ecto.Query, warn: false
  alias BlissfullySewn.Repo

  alias BlissfullySewn.Vat.Tariff

  @doc """
  Returns the list of vats.

  ## Examples

      iex> list_vats()
      [%Tariff{}, ...]

  """
  def list_vats do
    Repo.all(Tariff)
  end

  @doc """
  Gets a single tariff.

  Raises `Ecto.NoResultsError` if the Tariff does not exist.

  ## Examples

      iex> get_tariff!(123)
      %Tariff{}

      iex> get_tariff!(456)
      ** (Ecto.NoResultsError)

  """
  def get_tariff!(id), do: Repo.get!(Tariff, id)

  @doc """
  Creates a tariff.

  ## Examples

      iex> create_tariff(%{field: value})
      {:ok, %Tariff{}}

      iex> create_tariff(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_tariff(attrs \\ %{}) do
    %Tariff{}
    |> Tariff.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a tariff.

  ## Examples

      iex> update_tariff(tariff, %{field: new_value})
      {:ok, %Tariff{}}

      iex> update_tariff(tariff, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_tariff(%Tariff{} = tariff, attrs) do
    tariff
    |> Tariff.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a tariff.

  ## Examples

      iex> delete_tariff(tariff)
      {:ok, %Tariff{}}

      iex> delete_tariff(tariff)
      {:error, %Ecto.Changeset{}}

  """
  def delete_tariff(%Tariff{} = tariff) do
    Repo.delete(tariff)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking tariff changes.

  ## Examples

      iex> change_tariff(tariff)
      %Ecto.Changeset{data: %Tariff{}}

  """
  def change_tariff(%Tariff{} = tariff, attrs \\ %{}) do
    Tariff.changeset(tariff, attrs)
  end
end
