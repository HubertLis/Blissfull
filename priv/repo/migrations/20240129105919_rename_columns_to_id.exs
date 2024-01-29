defmodule BlissfullySewn.Repo.Migrations.RenameColumnsToId do
  use Ecto.Migration

  def change do
    alter table(:products) do
      modify :color,references(:colors), from: :integer
    end
    rename table(:products), :color, to: :color_id
  end
end
