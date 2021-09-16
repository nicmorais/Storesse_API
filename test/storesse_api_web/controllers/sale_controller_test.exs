defmodule StoresseApiWeb.SaleControllerTest do
  use StoresseApiWeb.ConnCase

  alias StoresseApi.Sales
  alias StoresseApi.Sales.Sale

  @create_attrs %{
    amount: "120.5",
    discount: "120.5"
  }
  @update_attrs %{
    amount: "456.7",
    discount: "456.7"
  }
  @invalid_attrs %{amount: nil, discount: nil}

  def fixture(:sale) do
    {:ok, sale} = Sales.create_sale(@create_attrs)
    sale
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all sales", %{conn: conn} do
      conn = get(conn, Routes.sale_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create sale" do
    test "renders sale when data is valid", %{conn: conn} do
      conn = post(conn, Routes.sale_path(conn, :create), sale: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.sale_path(conn, :show, id))

      assert %{
               "id" => id,
               "amount" => "120.5",
               "discount" => "120.5"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.sale_path(conn, :create), sale: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update sale" do
    setup [:create_sale]

    test "renders sale when data is valid", %{conn: conn, sale: %Sale{id: id} = sale} do
      conn = put(conn, Routes.sale_path(conn, :update, sale), sale: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.sale_path(conn, :show, id))

      assert %{
               "id" => id,
               "amount" => "456.7",
               "discount" => "456.7"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, sale: sale} do
      conn = put(conn, Routes.sale_path(conn, :update, sale), sale: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete sale" do
    setup [:create_sale]

    test "deletes chosen sale", %{conn: conn, sale: sale} do
      conn = delete(conn, Routes.sale_path(conn, :delete, sale))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.sale_path(conn, :show, sale))
      end
    end
  end

  defp create_sale(_) do
    sale = fixture(:sale)
    %{sale: sale}
  end
end
