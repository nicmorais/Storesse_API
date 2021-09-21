defmodule StoresseApi.States.State do
  use Ecto.Schema
  import Ecto.Changeset
  alias StoresseApi.Countries
  alias StoresseApi.Cities
  
  schema "states" do
    field :code, :string
    field :name, :string
    belongs_to(:country, Countries.Country)
    has_many(:cities, Cities.City)
  end

  @doc false
  def changeset(state, attrs) do
    state
    |> cast(attrs, [:name, :code, :country_id])
    |> validate_required([:name, :code])
    |> assoc_constraint(:country)
  end
end
