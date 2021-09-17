defmodule StoresseApi.Products.Product do
  use Ecto.Schema
  import Ecto.Changeset

  schema "products" do
    field :active, :boolean, default: true
    field :cost, :decimal
    field :name, :string
    field :price, :decimal
    field :quantity, :decimal

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :price, :cost, :quantity, :active])
    |> validate_required([:name, :price, :cost, :quantity, :active])
  end
end
