defmodule StoresseApiWeb.Router do
  use StoresseApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug StoresseApiWeb.Auth.Pipeline
  end

  scope "/api", StoresseApiWeb do
    pipe_through [:api, :auth]
    
    get "/customers/summary", CustomerController, :summary
    resources "/customers", CustomerController, except: [:new, :edit] do
      resources "/sales", SaleController, except: [:new, :edit] do
        resources "/sale_products", SaleProductController, except: [:new, :edit]
      end
    end
    
    resources "/sales", SaleController, except: [:new, :edit] do
      resources "/sale_products", SaleProductController, except: [:new, :edit]
    end
    
    resources "/products", ProductController, except: [:new, :edit]
    
    resources "/countries", CountryController, except: [:new, :edit] do
      resources "/states", StateController, except: [:new, :edit] do
        resources "/cities", CityController, except: [:new, :edit]
      end
    end
  end
  
  scope "/api", StoresseApiWeb do
    pipe_through :api
    post "/users/signin", UserController, :signin
  end
  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: StoresseApiWeb.Telemetry
    end
  end
end
