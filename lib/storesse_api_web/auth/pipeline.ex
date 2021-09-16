defmodule StoresseApiWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline, otp_app: :storesse_api,
    module: StoresseApiWeb.Auth.Guardian,
    error_handler: StoresseApiWeb.Auth.ErrorHandler

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end