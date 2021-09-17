# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :storesse_api,
  ecto_repos: [StoresseApi.Repo]

# Configures the endpoint
config :storesse_api, StoresseApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "GFt12XzbDZxCQwfIamFEtjvF5CX/rKpDh2K4NlmHHvnwe9ROM4F82xi1GjN3Hcqv",
  render_errors: [view: StoresseApiWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: StoresseApi.PubSub,
  live_view: [signing_salt: "6KAUf7WQ"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Poison for JSON parsing in Phoenix
config :phoenix, :json_library, Poison

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

config :storesse_api, StoresseApiWeb.Auth.Guardian,
  issuer: "storesse_api",
  secret_key: "LYH5yy0qtOaM1gS24sudtJgiq0Lxent2/JANhQfSJ6MihWDc++x2ywAvyiGQv7w/"