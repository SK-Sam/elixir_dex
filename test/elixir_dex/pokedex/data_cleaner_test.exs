defmodule ElixirDex.Pokedex.DataCleanerTest do
  use ElixirDex.DataCase

  alias ElixirDex.Pokedex.DataCleaner

  describe "remove_whitespace/1" do
    test "Fn returns new string without whitespaces only if args is a String" do
      assert DataCleaner.remove_whitespace("pokemon name") == "pokemonname"
    end

    test "Fn returns error tuple if non String is passed as an arg" do
      assert DataCleaner.remove_whitespace(1) == {:error, :incorrect_format}
      assert DataCleaner.remove_whitespace(false) == {:error, :incorrect_format}
      assert DataCleaner.remove_whitespace(:ditto) == {:error, :incorrect_format}
    end

    test "Fn returns original string if no whitespaces" do
      pkmn_name_no_spaces = "pokemonname"

      assert DataCleaner.remove_whitespace(pkmn_name_no_spaces) == pkmn_name_no_spaces
    end
  end
end
