defmodule StoresseApi.StatesTest do
  use StoresseApi.DataCase

  alias StoresseApi.States

  describe "states" do
    alias StoresseApi.States.State

    @valid_attrs %{code: "some code", name: "some name"}
    @update_attrs %{code: "some updated code", name: "some updated name"}
    @invalid_attrs %{code: nil, name: nil}

    def state_fixture(attrs \\ %{}) do
      {:ok, state} =
        attrs
        |> Enum.into(@valid_attrs)
        |> States.create_state()

      state
    end

    test "list_states/0 returns all states" do
      state = state_fixture()
      assert States.list_states() == [state]
    end

    test "get_state!/1 returns the state with given id" do
      state = state_fixture()
      assert States.get_state!(state.id) == state
    end

    test "create_state/1 with valid data creates a state" do
      assert {:ok, %State{} = state} = States.create_state(@valid_attrs)
      assert state.code == "some code"
      assert state.name == "some name"
    end

    test "create_state/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = States.create_state(@invalid_attrs)
    end

    test "update_state/2 with valid data updates the state" do
      state = state_fixture()
      assert {:ok, %State{} = state} = States.update_state(state, @update_attrs)
      assert state.code == "some updated code"
      assert state.name == "some updated name"
    end

    test "update_state/2 with invalid data returns error changeset" do
      state = state_fixture()
      assert {:error, %Ecto.Changeset{}} = States.update_state(state, @invalid_attrs)
      assert state == States.get_state!(state.id)
    end

    test "delete_state/1 deletes the state" do
      state = state_fixture()
      assert {:ok, %State{}} = States.delete_state(state)
      assert_raise Ecto.NoResultsError, fn -> States.get_state!(state.id) end
    end

    test "change_state/1 returns a state changeset" do
      state = state_fixture()
      assert %Ecto.Changeset{} = States.change_state(state)
    end
  end
end
