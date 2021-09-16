defmodule StoresseApi.Countries.Country do
  use Ecto.Schema
  import Ecto.Changeset
  
  alias StoresseApi.States.State
   
  schema "countries" do
    field :code, :string
    field :name, :string
    has_many(:states, State)
  end

  @doc false
  def changeset(country, attrs) do
    country
    |> cast(attrs, [:name, :code])
    |> validate_required([:name, :code])
  end
end
