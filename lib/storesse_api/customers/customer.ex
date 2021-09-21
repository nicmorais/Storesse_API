defmodule StoresseApi.Customers.Customer do
  use Ecto.Schema
  import Ecto.Changeset
  alias StoresseApi.Cities.City
  alias StoresseApi.Sales.Sale
  
  schema "customers" do
    field :address_line1, :string
    field :address_line2, :string
    field :birthdate, :date
    field :document, :string
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :name, :string
    field :zip_code, :string
    belongs_to(:city, City)
    has_many(:sales, Sale)

    timestamps()
  end

  @doc false
  def changeset(customer, attrs) do
    customer
    |> cast(attrs, [:name, :document, :address_line1, :address_line2, :zip_code, :birthdate, :email, :city_id])
    |> validate_required([:name, :document, :address_line1, :address_line2, :zip_code, :birthdate, :email])
    |> validate_format(:email, ~r/@/)
    |> validate_length(:email, min: 5, max: 40)
    |> validate_length(:name, min: 4, max: 50)
    |> validate_format(:name, ~r/ /)
    |> validate_length(:zip_code, min: 4, max: 16)
    |> assoc_constraint(:state)
  end
end
