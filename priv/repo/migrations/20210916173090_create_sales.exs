defmodule StoresseApi.Repo.Migrations.CreateSales do
  use Ecto.Migration

  def change do
    create table(:sales) do
      add :amount, :decimal, precision: 10, scale: 4, null: false
      add :discount, :decimal, precision: 10, scale: 4, default: 0
      add :customer_id, references(:customers, on_delete: :nothing)

      timestamps()
    end

    create index(:sales, [:customer_id])
  end
end
