defmodule StoresseApiWeb.SaleController do
  use StoresseApiWeb, :controller

  alias StoresseApi.Sales
  alias StoresseApi.Sales.Sale
  alias StoresseApi.Repo
  alias StoresseApi.Customers.Customer
  
  import Ecto.Query
  import DateTime
  import Date
  alias StoresseApi.Repo
  
  action_fallback StoresseApiWeb.FallbackController

  def index(conn, _params) do
    conn = Plug.Conn.fetch_query_params(conn)
    params = conn.query_params
    
    cond do
      params["customer_name"] == nil and params["date"] == nil ->
        sales = Repo.all(from(s in Sale, limit: 50)) 
        |> Repo.preload(:customer)
        render(conn, "index.json", sales: sales)

      params["customer_name"] != nil and params["date"] != nil ->
        customer_name = params["customer_name"] <> "%"
        start_date = params["date"] <> " 00:00:00"
        end_date = params["date"] <> " 23:59:59"
        sales = Repo.all(from s in Sale, order_by: s.inserted_at,
          join: c in Customer, on: c.id == s.customer_id,
          where: ilike(c.name, ^customer_name), 
          where: s.inserted_at >= ^start_date,
          where: s.inserted_at <= ^end_date,
          limit: 50)
          |> Repo.preload(customer: :sales)
        render(conn, "index.json", sales: sales)

      params["customer_name"] == nil and params["date"] != nil ->
        start_date = params["date"] <> " 00:00:00"
        end_date = params["date"] <> " 23:59:59"
        sales = Repo.all(from s in Sale, order_by: s.inserted_at,
          join: c in Customer, on: c.id == s.customer_id,
          where: s.inserted_at >= ^start_date,
          where: s.inserted_at <= ^end_date,
          limit: 50)
          |> Repo.preload(customer: :sales)
        render(conn, "index.json", sales: sales)

      params["customer_name"] != nil and params["date"] == nil ->
        customer_name = params["customer_name"] <> "%"
        sales = Repo.all(from s in Sale, order_by: s.inserted_at,
          join: c in Customer, on: c.id == s.customer_id,
          where: ilike(c.name, ^customer_name), 
          limit: 50)
          |> Repo.preload(customer: :sales)
        render(conn, "index.json", sales: sales)

    end
  end

  defp convert_date(date) do
  date
  |> Date.to_erl
  |> Date.from_erl!
  end

  def create(conn, %{"sale" => sale_params}) do
    with {:ok, %Sale{} = sale} <- Sales.create_sale(sale_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.sale_path(conn, :show, sale))
      |> render("show.json", sale: sale)
    end
  end

  def show(conn, %{"id" => id}) do
    sale = Sales.get_sale!(id)
    render(conn, "show.json", sale: sale)
  end

  def update(conn, %{"id" => id, "sale" => sale_params}) do
    sale = Sales.get_sale!(id)

    with {:ok, %Sale{} = sale} <- Sales.update_sale(sale, sale_params) do
      render(conn, "sale.json", sale: sale)
    end
  end

  def delete(conn, %{"id" => id}) do
    sale = Sales.get_sale!(id)

    with {:ok, %Sale{}} <- Sales.delete_sale(sale) do
      send_resp(conn, :no_content, "")
    end
  end
end
