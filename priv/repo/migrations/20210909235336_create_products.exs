defmodule StoresseApi.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add :name, :string, size: 60, null: false
      add :price, :decimal, precision: 10, scale: 5
      add :cost, :decimal, precision: 10, scale: 5
      add :quantity, :decimal, precision: 9, scale: 3, default: 1
      add :active, :boolean, default: true, null: false

      timestamps()
    end

  end
end
