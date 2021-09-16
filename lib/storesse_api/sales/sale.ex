defmodule StoresseApi.Sales.Sale do
  use Ecto.Schema
  import Ecto.Changeset
  alias StoresseApi.SaleProducts.SaleProduct
  alias StoresseApi.Customers.Customer

  schema "sales" do
    field :amount, :decimal
    field :discount, :decimal
    belongs_to(:customer, Customer)
    has_many(:sale_products, SaleProduct)
    
    timestamps()
  end

  @doc false
  def changeset(sale, attrs) do
    sale
    |> cast(attrs, [:amount, :discount, :customer_id])
    |> assoc_constraint(:customer)
    |> validate_required([:amount, :discount, :customer_id])
    |> cast_assoc(:sale_products)
  end
end
