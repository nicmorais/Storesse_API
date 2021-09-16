defmodule StoresseApi.Repo.Migrations.CreateSaleProducts do
  use Ecto.Migration

  def change do
    create table(:sale_products) do
      add :price, :decimal
      add :quantity, :decimal
      add :sale_id, references(:sales, on_delete: :nothing)
      add :product_id, references(:products, on_delete: :nothing)

      timestamps()
    end

    create index(:sale_products, [:sale_id])
    create index(:sale_products, [:product_id])
  end
end
