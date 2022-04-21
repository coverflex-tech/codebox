defmodule Codebox.Repo do
  use Ecto.Repo,
    otp_app: :codebox,
    adapter: Ecto.Adapters.Postgres
end
