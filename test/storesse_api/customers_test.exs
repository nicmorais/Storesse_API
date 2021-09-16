defmodule StoresseApi.CustomersTest do
  use StoresseApi.DataCase

  alias StoresseApi.Customers

  describe "customers" do
    alias StoresseApi.Customers.Customer

    @valid_attrs %{address_line1: "some address_line1", address_line2: "some address_line2", birthdate: ~D[2010-04-17], document: "some document", email: "some email", name: "some name", zip_code: "some zip_code"}
    @update_attrs %{address_line1: "some updated address_line1", address_line2: "some updated address_line2", birthdate: ~D[2011-05-18], document: "some updated document", email: "some updated email", name: "some updated name", zip_code: "some updated zip_code"}
    @invalid_attrs %{address_line1: nil, address_line2: nil, birthdate: nil, document: nil, email: nil, name: nil, zip_code: nil}

    def customer_fixture(attrs \\ %{}) do
      {:ok, customer} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Customers.create_customer()

      customer
    end

    test "list_customers/0 returns all customers" do
      customer = customer_fixture()
      assert Customers.list_customers() == [customer]
    end

    test "get_customer!/1 returns the customer with given id" do
      customer = customer_fixture()
      assert Customers.get_customer!(customer.id) == customer
    end

    test "create_customer/1 with valid data creates a customer" do
      assert {:ok, %Customer{} = customer} = Customers.create_customer(@valid_attrs)
      assert customer.address_line1 == "some address_line1"
      assert customer.address_line2 == "some address_line2"
      assert customer.birthdate == ~D[2010-04-17]
      assert customer.document == "some document"
      assert customer.email == "some email"
      assert customer.name == "some name"
      assert customer.zip_code == "some zip_code"
    end

    test "create_customer/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Customers.create_customer(@invalid_attrs)
    end

    test "update_customer/2 with valid data updates the customer" do
      customer = customer_fixture()
      assert {:ok, %Customer{} = customer} = Customers.update_customer(customer, @update_attrs)
      assert customer.address_line1 == "some updated address_line1"
      assert customer.address_line2 == "some updated address_line2"
      assert customer.birthdate == ~D[2011-05-18]
      assert customer.document == "some updated document"
      assert customer.email == "some updated email"
      assert customer.name == "some updated name"
      assert customer.zip_code == "some updated zip_code"
    end

    test "update_customer/2 with invalid data returns error changeset" do
      customer = customer_fixture()
      assert {:error, %Ecto.Changeset{}} = Customers.update_customer(customer, @invalid_attrs)
      assert customer == Customers.get_customer!(customer.id)
    end

    test "delete_customer/1 deletes the customer" do
      customer = customer_fixture()
      assert {:ok, %Customer{}} = Customers.delete_customer(customer)
      assert_raise Ecto.NoResultsError, fn -> Customers.get_customer!(customer.id) end
    end

    test "change_customer/1 returns a customer changeset" do
      customer = customer_fixture()
      assert %Ecto.Changeset{} = Customers.change_customer(customer)
    end
  end
end
