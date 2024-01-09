defmodule Rockelivery.Repo.Migrations.CreateUsersTable do
  use Ecto.Migration

  # `mix ecto.gen.migration create_users_table` to generate files like this
  # `mix ecto.migrate` to run migrations
  def change do
    create table(:users) do
      # id is created automatically by Ecto as an auto-incrementing integer
      add :address, :string
      add :age, :integer
      add :cep, :string
      add :cpf, :string
      add :email, :string
      add :password_hash, :string
      add :name, :string

      # created_at, updated_at
      timestamps()
    end

    create unique_index(:users, [:cpf])
    create unique_index(:users, [:email])
  end
end
