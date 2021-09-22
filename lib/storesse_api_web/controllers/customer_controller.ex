defmodule StoresseApiWeb.CustomerController do
  use StoresseApiWeb, :controller

  alias StoresseApi.Customers
  alias StoresseApi.Customers.Customer
  
  action_fallback StoresseApiWeb.FallbackController

  import Ecto.Query
  alias StoresseApi.Repo
  
  def index(conn, _params) do
    conn = Plug.Conn.fetch_query_params(conn)
    params = conn.query_params
    name = params["name"]
    
    if name == nil do
      customers = from(c in Customer, limit: 50)
      |> Repo.all()
      render(conn, "index.json", customers: customers)
    else
      name = params["name"] <> "%"
      customers = from(c in Customer, where: ilike(c.name, ^name), limit: 50) 
      |> Repo.all()
    render(conn, "index.json", customers: customers)
    end
  end
  
  def create(conn, %{"customer" => customer_params}) do
    with {:ok, %Customer{} = customer} <- Customers.create_customer(customer_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.customer_path(conn, :show, customer))
      |> render("show.json", customer: customer)
    end
  end

  def show(conn, %{"id" => id}) do
    customer = Customers.get_customer!(id)
    render(conn, "show.json", customer: customer)
  end

  def update(conn, %{"id" => id, "customer" => customer_params}) do
    customer = Customers.get_customer!(id)

    with {:ok, %Customer{} = customer} <- Customers.update_customer(customer, customer_params) do
      render(conn, "show.json", customer: customer)
    end
  end

  def delete(conn, %{"id" => id}) do
    customer = Customers.get_customer!(id)

    with {:ok, %Customer{}} <- Customers.delete_customer(customer) do
      send_resp(conn, :no_content, "")
    end
  end
end
