defmodule StoresseApi.Repo.Migrations.CreateCountries do
  use Ecto.Migration

  def change do
    create table(:countries) do
      add :name, :string, length: 45, null: false
      add :code, :string, length: 2, null: false
      
      timestamps()
    end

  end
end
