defmodule ElixirDex.Repo.Migrations.CreatePokemon do
  use Ecto.Migration

  def change do
    create table(:pokemon) do
      add :name, :string
      add :pokedex_id, :integer
      add :type, :string

      timestamps()
    end

    create unique_index(:pokemon, [:pokedex_id])
    create unique_index(:pokemon, [:name])
  end
end
