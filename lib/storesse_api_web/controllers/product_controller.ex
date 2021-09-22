defmodule StoresseApiWeb.ProductController do
  use StoresseApiWeb, :controller

  alias StoresseApi.Products
  alias StoresseApi.Products.Product

  import Ecto.Query
  alias StoresseApi.Repo

  action_fallback StoresseApiWeb.FallbackController

  def index(conn, _params) do
    conn = Plug.Conn.fetch_query_params(conn)
    params = conn.query_params
    name = params["name"]
    if params["name"] == nil do
      products = from(p in Product, limit: 50)
      |> Repo.all()
      render(conn, "index.json", products: products)
    else
      name = params["name"] <> "%"
      products = from(p in Product, where: ilike(p.name, ^name), limit: 50) 
      |> Repo.all()
    render(conn, "index.json", products: products)
    end
  end

  def create(conn, %{"product" => product_params}) do
    with {:ok, %Product{} = product} <- Products.create_product(product_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.product_path(conn, :show, product))
      |> render("show.json", product: product)
    end
  end

  def show(conn, %{"id" => id}) do
    product = Products.get_product!(id)
    render(conn, "show.json", product: product)
  end

  def update(conn, %{"id" => id, "product" => product_params}) do
    product = Products.get_product!(id)

    with {:ok, %Product{} = product} <- Products.update_product(product, product_params) do
      render(conn, "show.json", product: product)
    end
  end

  def delete(conn, %{"id" => id}) do
    product = Products.get_product!(id)

    with {:ok, %Product{}} <- Products.delete_product(product) do
      send_resp(conn, :no_content, "")
    end
  end
end
