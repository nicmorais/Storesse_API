defmodule StoresseApiWeb.SaleProductControllerTest do
  use StoresseApiWeb.ConnCase

  alias StoresseApi.SaleProducts
  alias StoresseApi.SaleProducts.SaleProduct

  @create_attrs %{
    price: "120.5",
    quantity: "120.5"
  }
  @update_attrs %{
    price: "456.7",
    quantity: "456.7"
  }
  @invalid_attrs %{price: nil, quantity: nil}

  def fixture(:sale_product) do
    {:ok, sale_product} = SaleProducts.create_sale_product(@create_attrs)
    sale_product
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all sale_products", %{conn: conn} do
      conn = get(conn, Routes.sale_product_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create sale_product" do
    test "renders sale_product when data is valid", %{conn: conn} do
      conn = post(conn, Routes.sale_product_path(conn, :create), sale_product: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.sale_product_path(conn, :show, id))

      assert %{
               "id" => id,
               "price" => "120.5",
               "quantity" => "120.5"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.sale_product_path(conn, :create), sale_product: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update sale_product" do
    setup [:create_sale_product]

    test "renders sale_product when data is valid", %{conn: conn, sale_product: %SaleProduct{id: id} = sale_product} do
      conn = put(conn, Routes.sale_product_path(conn, :update, sale_product), sale_product: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.sale_product_path(conn, :show, id))

      assert %{
               "id" => id,
               "price" => "456.7",
               "quantity" => "456.7"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, sale_product: sale_product} do
      conn = put(conn, Routes.sale_product_path(conn, :update, sale_product), sale_product: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete sale_product" do
    setup [:create_sale_product]

    test "deletes chosen sale_product", %{conn: conn, sale_product: sale_product} do
      conn = delete(conn, Routes.sale_product_path(conn, :delete, sale_product))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.sale_product_path(conn, :show, sale_product))
      end
    end
  end

  defp create_sale_product(_) do
    sale_product = fixture(:sale_product)
    %{sale_product: sale_product}
  end
end
