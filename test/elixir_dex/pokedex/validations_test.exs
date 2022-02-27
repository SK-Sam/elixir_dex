defmodule ElixirDex.Pokedex.ValidationsTest do
  use ElixirDex.DataCase

  alias ElixirDex.Pokedex.Validations

  describe "maybe_add_errors/1" do
    test "return error when input isn't String" do
      expected_error = {:error, :incorrect_format}

      assert Validations.maybe_add_errors(:ditto) == expected_error
      assert Validations.maybe_add_errors(1) == expected_error
      assert Validations.maybe_add_errors(false) == expected_error
    end

    test "return original string when input is a String unless empty string" do
      pkmn_name = "ditto"

      assert Validations.maybe_add_errors(pkmn_name) == pkmn_name
      assert Validations.maybe_add_errors("") == {:error, :empty_string}
    end
  end
end
