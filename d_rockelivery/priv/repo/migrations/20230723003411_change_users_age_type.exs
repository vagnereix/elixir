defmodule Rockelivery.Repo.Migrations.ChangeUsersAgeType do
  use Ecto.Migration

  def change do
    alter table(:users) do
      remove :age
      add :age, :integer
    end
  end
end
