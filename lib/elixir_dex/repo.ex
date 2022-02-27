defmodule ElixirDex.Repo do
  use Ecto.Repo,
    otp_app: :elixir_dex,
    adapter: Ecto.Adapters.Postgres
end
