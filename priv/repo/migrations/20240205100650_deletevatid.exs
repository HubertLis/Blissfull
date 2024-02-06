defmodule BlissfullySewn.Repo.Migrations.Deletevatid do
  use Ecto.Migration

  def change do
    alter table(:products) do
      remove :vat_id
      add :vat, :decimal
    end
  end
end
