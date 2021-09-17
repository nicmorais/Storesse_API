defmodule StoresseApiWeb.SaleController do
  use StoresseApiWeb, :controller

  alias StoresseApi.Sales
  alias StoresseApi.Sales.Sale

  action_fallback StoresseApiWeb.FallbackController

#  def index(conn, _params) do
def index(conn, %{"sale_id" => sale_id}) do
#    sales = Sales.list_sales()
    sale = Sales.get_sale!(sale_id)
#    render(conn, "index.json", sales: sales)
#    render(conn, "sale.json", sale: sale)
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
