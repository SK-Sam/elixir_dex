defmodule ElixirDex.Entities.PokemonTest do
  use ElixirDex.DataCase

  alias ElixirDex.Entities.Pokemon
  alias ElixirDex.Repo

  describe "changeset/2" do
    test "successful changeset is a Pokemon with all fields, name and pokedex ID are unique" do
      name = "ditto"
      pokedex_id = 132
      type = "normal"

      attrs = %{
        name: name,
        pokedex_id: pokedex_id,
        type: type
      }

      cs =
        %Pokemon{}
        |> Pokemon.changeset(attrs)

      assert cs.valid?
    end

    test "unsuccessful changesets" do
      # Insert Pokemon to check against in terms of uniqueness
      name = "ditto"
      pokedex_id = 132
      type = "normal"

      attrs = %{
        name: name,
        pokedex_id: pokedex_id,
        type: type
      }

      {:ok, pkmn_in_db} =
        %Pokemon{}
        |> Pokemon.changeset(attrs)
        |> Repo.insert()

      # Check for unique ID
      non_unique_id_attrs = %{
        name: "some other name",
        pokedex_id: pkmn_in_db.pokedex_id,
        type: type
      }

      invalid_id_cs =
        %Pokemon{}
        |> Pokemon.changeset(non_unique_id_attrs)

      refute invalid_id_cs.valid?
      assert [pokedex_id: {error_reason, _}] = invalid_id_cs.errors
      assert error_reason = "has already been taken"

      # Check for unique name
      non_unique_name_attrs =
        Map.merge(non_unique_id_attrs, %{name: pkmn_in_db.name, pokedex_id: 0})

      invalid_name_cs =
        %Pokemon{}
        |> Pokemon.changeset(non_unique_name_attrs)

      refute invalid_name_cs.valid?
      assert [name: {error_reason, _}] = invalid_name_cs.errors
      assert error_reason = "has already been taken"
    end
  end
end
