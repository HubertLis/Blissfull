defmodule BlissfullySewn.Sizes.Size do
  use Ecto.Schema
  import Ecto.Changeset

  schema "size" do
    field :name, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(size, attrs) do
    size
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
