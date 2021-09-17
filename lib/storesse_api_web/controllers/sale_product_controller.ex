defmodule StoresseApiWeb.SaleProductController do
  use StoresseApiWeb, :controller

  alias StoresseApi.Sales
  alias StoresseApi.SaleProducts
  alias StoresseApi.SaleProducts.SaleProduct

  action_fallback StoresseApiWeb.FallbackController

  def index(conn, %{"sale_id" => sale_id}) do
    #sale_products = SaleProducts.list_sale_products()
    sale_products = SaleProducts.get_sale_products_for_sale!(sale_id)
    render(conn, "index.json", sale_products: sale_products)
  end

  def create(conn, %{"sale_id" => sale_id, "sale_product" => sale_product_params}) do
    sale = Sales.get_sale!(sale_id)
    with {:ok, %SaleProduct{} = sale_product} <- SaleProducts.create_sale_product(sale, sale_product_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.sale_product_path(conn, :show, sale_product))
      |> render("show.json", sale_product: sale_product)
    end
  end

  def show(conn, %{"id" => id}) do
    sale_product = SaleProducts.get_sale_product!(id)
    render(conn, "show.json", sale_product: sale_product)
  end

  def update(conn, %{"id" => id, "sale_product" => sale_product_params}) do
    sale_product = SaleProducts.get_sale_product!(id)

    with {:ok, %SaleProduct{} = sale_product} <- SaleProducts.update_sale_product(sale_product, sale_product_params) do
      render(conn, "show.json", sale_product: sale_product)
    end
  end

  def delete(conn, %{"id" => id}) do
    sale_product = SaleProducts.get_sale_product!(id)

    with {:ok, %SaleProduct{}} <- SaleProducts.delete_sale_product(sale_product) do
      send_resp(conn, :no_content, "")
    end
  end
end
