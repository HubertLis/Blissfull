defmodule BlissfullySewn.ProductCatalog do
  @moduledoc """
  The ProductCatalog context.
  """

  import Ecto.Query, warn: false
  alias BlissfullySewn.Repo

  alias BlissfullySewn.ProductCatalog.ProductSize

  @doc """
  Returns the list of product_sizes.

  ## Examples

      iex> list_product_sizes()
      [%ProductSize{}, ...]

  """
  def list_product_sizes do
    Repo.all(ProductSize)
  end

  @doc """
  Gets a single product_size.

  Raises `Ecto.NoResultsError` if the Product size does not exist.

  ## Examples

      iex> get_product_size!(123)
      %ProductSize{}

      iex> get_product_size!(456)
      ** (Ecto.NoResultsError)

  """
  def get_product_size!(id), do: Repo.get!(ProductSize, id)

  @doc """
  Creates a product_size.

  ## Examples

      iex> create_product_size(%{field: value})
      {:ok, %ProductSize{}}

      iex> create_product_size(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_product_size(attrs \\ %{}) do
    %ProductSize{}
    |> ProductSize.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a product_size.

  ## Examples

      iex> update_product_size(product_size, %{field: new_value})
      {:ok, %ProductSize{}}

      iex> update_product_size(product_size, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_product_size(%ProductSize{} = product_size, attrs) do
    product_size
    |> ProductSize.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a product_size.

  ## Examples

      iex> delete_product_size(product_size)
      {:ok, %ProductSize{}}

      iex> delete_product_size(product_size)
      {:error, %Ecto.Changeset{}}

  """
  def delete_product_size(%ProductSize{} = product_size) do
    Repo.delete(product_size)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking product_size changes.

  ## Examples

      iex> change_product_size(product_size)
      %Ecto.Changeset{data: %ProductSize{}}

  """
  def change_product_size(%ProductSize{} = product_size, attrs \\ %{}) do
    ProductSize.changeset(product_size, attrs)
  end
end
