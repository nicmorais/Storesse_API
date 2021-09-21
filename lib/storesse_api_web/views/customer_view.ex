defmodule StoresseApiWeb.CustomerView do
  use StoresseApiWeb, :view
  alias StoresseApiWeb.CustomerView

  def render("index.json", %{customers: customers}) do
    %{data: render_many(customers, CustomerView, "customer.json")}
  end

  def render("show.json", %{customer: customer}) do
    %{data: render_one(customer, CustomerView, "customer.json")}
  end

  def render("customer.json", %{customer: customer}) do
    %{id: customer.id,
      name: customer.name,
      document: customer.document,
      address_line1: customer.address_line1,
      address_line2: customer.address_line2,
      city_id: customer.city_id,
      zip_code: customer.zip_code,
      birthdate: customer.birthdate,
      email: customer.email}
  end
  
    def render("customer_summary.json", %{customer: customer}) do
    %{id: customer.id,
      name: customer.name,
      document: customer.document,
      address_line1: customer.address_line1,
      address_line2: customer.address_line2,
      city_id: customer.city_id,
      state_id: customer.city.state_id,
      city_name: customer.city.name,
      zip_code: customer.zip_code,
      birthdate: customer.birthdate,
      email: customer.email}
  end
end
