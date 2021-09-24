defmodule StoresseApiWeb.StateView do
  use StoresseApiWeb, :view
  alias StoresseApiWeb.StateView

  def render("index.json", %{states: states}) do
    %{data: render_many(states, StateView, "state.json")}
  end

  def render("show.json", %{state: state}) do
    %{data: render_one(state, StateView, "state.json")}
  end

  def render("state.json", %{state: state}) do
    %{id: state.id,
      name: state.name,
      code: state.code,
      country_id: state.country.id
      }
  end
end
