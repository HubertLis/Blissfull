defmodule BlissfullySewn.Repo.Migrations.CreateColors do
  use Ecto.Migration

  def change do
    create table(:colors) do
      add :name, :string

      timestamps(type: :utc_datetime)
    end
  end
end
