defmodule StoresseApiWeb.SaleProductView do
  use StoresseApiWeb, :view
  alias StoresseApiWeb.SaleProductView

  def render("index.json", %{sale_products: sale_products}) do
    %{data: render_many(sale_products, SaleProductView, "sale_product.json")}
  end

  def render("show.json", %{sale_product: sale_product}) do
    %{data: render_one(sale_product, SaleProductView, "sale_product.json")}
  end

  def render("sale_product.json", %{sale_product: sale_product}) do
    %{id: sale_product.id,
      price: sale_product.price,
      quantity: sale_product.quantity}
  end
end
