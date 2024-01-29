defmodule :"Elixir.BlissfullySewn.Repo.Migrations.RenameColumnsToId@" do
  use Ecto.Migration

    def change do
      alter table(:products) do
        modify :size,references(:size), from: :integer
      end
      rename table(:products), :size, to: :size_id
    end
end
