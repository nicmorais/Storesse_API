defmodule StoresseApi.States.State do
  use Ecto.Schema
  import Ecto.Changeset
  alias StoresseApi.Countries.Country
  alias StoresseApi.Cities.City
  
  schema "states" do
    field :code, :string
    field :name, :string
    belongs_to(:country, Country)
    has_many(:cities, City)
  end

  @doc false
  def changeset(state, attrs) do
    state
    |> cast(attrs, [:name, :code, :country_id])
    |> validate_required([:name, :code])
    |> assoc_constraint(:country)
    |> cast_assoc(:city)
  end
end
