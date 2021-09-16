defmodule StoresseApiWeb.CustomerControllerTest do
  use StoresseApiWeb.ConnCase

  alias StoresseApi.Customers
  alias StoresseApi.Customers.Customer

  @create_attrs %{
    address_line1: "some address_line1",
    address_line2: "some address_line2",
    birthdate: ~D[2010-04-17],
    document: "some document",
    email: "some email",
    name: "some name",
    zip_code: "some zip_code"
  }
  @update_attrs %{
    address_line1: "some updated address_line1",
    address_line2: "some updated address_line2",
    birthdate: ~D[2011-05-18],
    document: "some updated document",
    email: "some updated email",
    name: "some updated name",
    zip_code: "some updated zip_code"
  }
  @invalid_attrs %{address_line1: nil, address_line2: nil, birthdate: nil, document: nil, email: nil, name: nil, zip_code: nil}

  def fixture(:customer) do
    {:ok, customer} = Customers.create_customer(@create_attrs)
    customer
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all customers", %{conn: conn} do
      conn = get(conn, Routes.customer_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create customer" do
    test "renders customer when data is valid", %{conn: conn} do
      conn = post(conn, Routes.customer_path(conn, :create), customer: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.customer_path(conn, :show, id))

      assert %{
               "id" => id,
               "address_line1" => "some address_line1",
               "address_line2" => "some address_line2",
               "birthdate" => "2010-04-17",
               "document" => "some document",
               "email" => "some email",
               "name" => "some name",
               "zip_code" => "some zip_code"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.customer_path(conn, :create), customer: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update customer" do
    setup [:create_customer]

    test "renders customer when data is valid", %{conn: conn, customer: %Customer{id: id} = customer} do
      conn = put(conn, Routes.customer_path(conn, :update, customer), customer: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.customer_path(conn, :show, id))

      assert %{
               "id" => id,
               "address_line1" => "some updated address_line1",
               "address_line2" => "some updated address_line2",
               "birthdate" => "2011-05-18",
               "document" => "some updated document",
               "email" => "some updated email",
               "name" => "some updated name",
               "zip_code" => "some updated zip_code"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, customer: customer} do
      conn = put(conn, Routes.customer_path(conn, :update, customer), customer: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete customer" do
    setup [:create_customer]

    test "deletes chosen customer", %{conn: conn, customer: customer} do
      conn = delete(conn, Routes.customer_path(conn, :delete, customer))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.customer_path(conn, :show, customer))
      end
    end
  end

  defp create_customer(_) do
    customer = fixture(:customer)
    %{customer: customer}
  end
end
