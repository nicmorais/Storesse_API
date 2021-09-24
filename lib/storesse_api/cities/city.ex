defmodule StoresseApi.Cities.City do
  use Ecto.Schema
  import Ecto.Changeset
  alias Storesse.States
  alias Storesse.Customers
  alias Storesse.States.State
  
  schema "cities" do
    field :name, :string
    belongs_to(:state, State)
    has_many(:customers, Customers.Customer)

    timestamps()
  end

  @doc false
  def changeset(city, attrs) do
    city
    |> cast(attrs, [:name, :state_id])
    |> validate_required([:name, :state_id])
    |> assoc_constraint(:state)
    |> cast_assoc(:customer)
  end
end
