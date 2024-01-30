defmodule BlissfullySewn.Repo.Migrations.CreateVats do
  use Ecto.Migration

  def change do
    create table(:vats) do
      add :vat, :decimal

      timestamps(type: :utc_datetime)
    end
  end
end
