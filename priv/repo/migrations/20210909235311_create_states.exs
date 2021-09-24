defmodule StoresseApi.Repo.Migrations.CreateStates do
  use Ecto.Migration

  def change do
    create table(:states) do
      add :name, :string, size: 52, null: false
      add :code, :string, size: 6
      add :country_id, references(:countries, on_delete: :delete_all)
      
      timestamps()
    end

    create index(:states, [:country_id])
  end
end
