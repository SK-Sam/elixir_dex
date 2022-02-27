defmodule ElixirDex.Pokedex.DataCleanerTest do
  use ElixirDex.DataCase

  alias ElixirDex.Pokedex.DataCleaner

  describe "remove_whitespace/1" do
    test "Fn returns new string without whitespaces" do
      assert DataCleaner.remove_whitespace("pokemon name") == "pokemonname"
    end

    test "Fn returns original string if no whitespaces" do
      pkmn_name_no_spaces = "pokemonname"

      assert DataCleaner.remove_whitespace(pkmn_name_no_spaces) == pkmn_name_no_spaces
    end
  end

  describe "clean_data/1" do
    test "Fn returns downcased string with no whitespace" do
      original_input = "D iTtoe"
      expected_output = "dittoe"

      assert DataCleaner.clean_data(original_input) == expected_output

      good_input = "dittoo"

      assert DataCleaner.clean_data(good_input) == good_input
    end
  end
end
