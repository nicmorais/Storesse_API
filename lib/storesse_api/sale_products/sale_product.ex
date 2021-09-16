defmodule StoresseApi.SaleProducts.SaleProduct do
  use Ecto.Schema
  import Ecto.Changeset
  alias StoresseApi.Products.Product

  schema "sale_products" do
    field :price, :decimal
    field :quantity, :decimal
    belongs_to(:sale, Sale)
    belongs_to(:product, Product)

    timestamps()
  end

  @doc false
  def changeset(sale_product, attrs) do
    sale_product
#    |> assoc_constraint(:products)
    |> cast(attrs, [:price, :quantity, :sale_id, :product_id])
    |> assoc_constraint(:sale)
    |> validate_required([:price, :quantity, :sale_id, :product_id])
  end
end
