defmodule Serve.Repo.Migrations.CreateCamera do
  use Ecto.Migration

  def change do
    create table(:cameras) do
      add :name, :string
      add :address, :string
      add :digits, :decimal

      timestamps
    end

  end
end
