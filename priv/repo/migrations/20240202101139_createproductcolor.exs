defmodule BlissfullySewn.Repo.Migrations.Createproductcolor do
  use Ecto.Migration

  def change do
    create table("products_colors",primary_key: false) do
      add :product_id, references(:products),primary: true
      add :color_id, references(:colors),primary: true
    end
  end
end
