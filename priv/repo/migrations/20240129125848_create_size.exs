defmodule BlissfullySewn.Repo.Migrations.CreateSize do
  use Ecto.Migration

  def change do
    create table(:size) do
      add :name, :string

      timestamps(type: :utc_datetime)
    end
  end
end
