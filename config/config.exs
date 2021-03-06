# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :elixir_dex,
  ecto_repos: [ElixirDex.Repo]

# Configures the endpoint
config :elixir_dex, ElixirDexWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "X0jFuQgI/5VqORtyrKi8iI/ZJv8HPCfgrWyC9kwbGjubFwHtJ+uXRaMWwFsRrGV5",
  render_errors: [view: ElixirDexWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: ElixirDex.PubSub,
  live_view: [signing_salt: "0nAWNuw/"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Utilize Hackney as default adapter:heavy_plus_sign:
config :tesla, adapter: Tesla.Adapter.Hackney

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
