defmodule StoresseApi.Repo.Migrations.CreateCountries do
  use Ecto.Migration

  def change do
    create table(:countries) do
      add :name, :string, size: 45, null: false
      add :code, :string, size: 2, null: false
      
      timestamps()
    end

  end
end
