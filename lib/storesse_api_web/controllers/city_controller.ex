defmodule StoresseApiWeb.CityController do
  use StoresseApiWeb, :controller

  alias StoresseApi.Cities
  alias StoresseApi.Cities.City
  alias StoresseApi.States.State
  
  action_fallback StoresseApiWeb.FallbackController
  alias StoresseApi.Repo
  import Ecto.Query
  
  def index(conn, %{"state_id" => state_id}) do
    cities = from(c in City, where: c.state_id == ^state_id)
    |> Repo.all()
    
    render(conn, "index.json", cities: cities)
  end

  def create(conn, %{"city" => city_params}) do
    with {:ok, %City{} = city} <- Cities.create_city(city_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.city_path(conn, :show, city))
      |> render("show.json", city: city)
    end
  end

  def show(conn, %{"id" => id}) do
    city = Cities.get_city!(id)
    render(conn, "show.json", city: city)
  end

  def update(conn, %{"id" => id, "city" => city_params}) do
    city = Cities.get_city!(id)

    with {:ok, %City{} = city} <- Cities.update_city(city, city_params) do
      render(conn, "show.json", city: city)
    end
  end

  def delete(conn, %{"id" => id}) do
    city = Cities.get_city!(id)

    with {:ok, %City{}} <- Cities.delete_city(city) do
      send_resp(conn, :no_content, "")
    end
  end
end
