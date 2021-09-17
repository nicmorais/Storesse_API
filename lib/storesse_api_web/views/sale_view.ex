defmodule StoresseApiWeb.SaleView do
  use StoresseApiWeb, :view
  alias StoresseApiWeb.SaleView
  alias StoresseApiWeb.SaleProductView
  alias StoresseApiWeb.CustomerView
  
  def render("index.json", %{sales: sales}) do
    %{data: render_many(sales, SaleView, "sale.json")}
  end

  def render("show.json", %{sale: sale}) do
    %{data: render_one(sale, SaleView, "show_sale_with_products.json")}
  end

  def render("sale.json", %{sale: sale}) do
    %{id: sale.id,
      amount: sale.amount,
      discount: sale.discount,
      customer_id: sale.customer_id}
  end

  def render("show_sale_with_products.json", %{sale: sale}) do
    %{id: sale.id,
      amount: sale.amount,
      discount: sale.discount,
      customer: render_one(sale.customer, CustomerView, "customer.json"),
      sale_products: render_many(sale.sale_products, SaleProductView, "sale_product.json")
     }
  end
  
  defimpl Poison.Encoder, for: Decimal do
  def encode(decimal, options) do
     Decimal.to_string(decimal, :normal)
    |> Poison.Encoder.encode(options)
  end
end

end
