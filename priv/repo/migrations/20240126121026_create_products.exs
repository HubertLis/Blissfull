defmodule BlissfullySewn.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :name, :string
      add :price, :decimal
      add :vat, :integer
      add :color, :integer
      add :size, :integer

      timestamps(type: :utc_datetime)
    end
  end
end
