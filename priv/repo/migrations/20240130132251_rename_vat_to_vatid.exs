defmodule :"Elixir.BlissfullySewn.Repo.Migrations.RenameColumnsToId@" do
  use Ecto.Migration

    def change do
      alter table(:products) do
        modify :vat,references(:vats), from: :integer
      end
      rename table(:products), :vat, to: :vat_id
    end
end
