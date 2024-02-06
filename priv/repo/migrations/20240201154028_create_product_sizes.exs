defmodule BlissfullySewn.Repo.Migrations.CreateProductSizes do
  use Ecto.Migration

  def change do
    create table(:product_sizes, primary_key: false) do
      add :product_id, references(:products, type: :integer, on_delete: :delete_all), primary_key: true
      add :size_id, references(:size, type: :integer, on_delete: :delete_all), primary_key: true
      add :price, :decimal
      timestamps()
    end

    create unique_index(:product_sizes, [:product_id, :size_id])
  end
end
