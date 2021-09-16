defmodule StoresseApi.Repo do
  use Ecto.Repo,
    otp_app: :storesse_api,
    adapter: Ecto.Adapters.Postgres
end
