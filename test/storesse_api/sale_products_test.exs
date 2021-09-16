defmodule StoresseApi.SaleProductsTest do
  use StoresseApi.DataCase

  alias StoresseApi.SaleProducts

  describe "sale_products" do
    alias StoresseApi.SaleProducts.SaleProduct

    @valid_attrs %{price: "120.5", quantity: "120.5"}
    @update_attrs %{price: "456.7", quantity: "456.7"}
    @invalid_attrs %{price: nil, quantity: nil}

    def sale_product_fixture(attrs \\ %{}) do
      {:ok, sale_product} =
        attrs
        |> Enum.into(@valid_attrs)
        |> SaleProducts.create_sale_product()

      sale_product
    end

    test "list_sale_products/0 returns all sale_products" do
      sale_product = sale_product_fixture()
      assert SaleProducts.list_sale_products() == [sale_product]
    end

    test "get_sale_product!/1 returns the sale_product with given id" do
      sale_product = sale_product_fixture()
      assert SaleProducts.get_sale_product!(sale_product.id) == sale_product
    end

    test "create_sale_product/1 with valid data creates a sale_product" do
      assert {:ok, %SaleProduct{} = sale_product} = SaleProducts.create_sale_product(@valid_attrs)
      assert sale_product.price == Decimal.new("120.5")
      assert sale_product.quantity == Decimal.new("120.5")
    end

    test "create_sale_product/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = SaleProducts.create_sale_product(@invalid_attrs)
    end

    test "update_sale_product/2 with valid data updates the sale_product" do
      sale_product = sale_product_fixture()
      assert {:ok, %SaleProduct{} = sale_product} = SaleProducts.update_sale_product(sale_product, @update_attrs)
      assert sale_product.price == Decimal.new("456.7")
      assert sale_product.quantity == Decimal.new("456.7")
    end

    test "update_sale_product/2 with invalid data returns error changeset" do
      sale_product = sale_product_fixture()
      assert {:error, %Ecto.Changeset{}} = SaleProducts.update_sale_product(sale_product, @invalid_attrs)
      assert sale_product == SaleProducts.get_sale_product!(sale_product.id)
    end

    test "delete_sale_product/1 deletes the sale_product" do
      sale_product = sale_product_fixture()
      assert {:ok, %SaleProduct{}} = SaleProducts.delete_sale_product(sale_product)
      assert_raise Ecto.NoResultsError, fn -> SaleProducts.get_sale_product!(sale_product.id) end
    end

    test "change_sale_product/1 returns a sale_product changeset" do
      sale_product = sale_product_fixture()
      assert %Ecto.Changeset{} = SaleProducts.change_sale_product(sale_product)
    end
  end
end
