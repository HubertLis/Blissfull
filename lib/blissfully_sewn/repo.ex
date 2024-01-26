defmodule BlissfullySewn.Repo do
  use Ecto.Repo,
    otp_app: :blissfully_sewn,
    adapter: Ecto.Adapters.Postgres
end
