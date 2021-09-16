defmodule StoresseApi.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string, size: 50, null: false
      add :password, :string, virtual: true
      add :password_hash, :string, size: 65, null: false
      add :role, :string, size: 10
      
      timestamps()
    end

    create unique_index(:users, [:email])
  end
end
