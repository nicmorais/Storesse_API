defmodule StoresseApi.Repo.Migrations.CreateCustomers do
  use Ecto.Migration

  def change do
    create table(:customers) do
      add :name, :string, size: 50, null: false
      add :document, :string, size: 15, null: true
      add :address_line1, :string, size: 50, null: false
      add :address_line2, :string, size: 50, null: false
      add :zip_code, :string, size: 16, null: false
      add :birthdate, :date
      add :email, :string, size: 40, null: false
      add :password_hash, :string, size: 65
      add :city_id, references(:cities, on_delete: :nilify_all, on_update: :update_all)

      timestamps()
    end

    create index(:customers, [:city_id])
  end
end
