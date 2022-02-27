defmodule ElixirDex.Pokedex.DataFetcherTest do
  use ElixirDex.DataCase

  alias ElixirDex.Pokedex.DataFetcher

  import Tesla.Mock

  setup do
    mock(fn
      %{method: :get, url: "https://pokeapi.co/api/v2/pokemon/ditto"} ->
        %Tesla.Env{status: 200, body: %{"name" => "dittoe", "id" => "1"}}

        %{method: :get, url: "https://pokeapi.co/api/v2/pokemon/1"} ->
          %Tesla.Env{status: 200, body: %{"name" => "dittoe", "id" => "1"}}

        %{method: :get, url: "https://pokeapi.co/api/v2/pokemon/dottoe"} ->
          %Tesla.Env{status: 404}

        %{method: :get, url: "https://pokeapi.co/api/v2/pokemon/10000"} ->
          %Tesla.Env{status: 404}
    end)

    :ok
  end

  describe "pokemon_name_or_id/2" do
    test "check happy paths" do
      fake_ditto_id = "1"
      fake_ditto_name = "dittoe"
      client = DataFetcher.client()

      assert DataFetcher.pokemon_name_or_id(client, "ditto") == fake_ditto_id
      assert DataFetcher.pokemon_name_or_id(client, "1") == fake_ditto_name
    end

    test "check sad paths" do
      bad_ditto_id = "10000"
      bad_ditto_name = "dottoe"
      expected_error = "Not Found"
      client = DataFetcher.client()

      assert DataFetcher.pokemon_name_or_id(client, bad_ditto_name) == expected_error
      assert DataFetcher.pokemon_name_or_id(client, bad_ditto_id) == expected_error
    end
  end
end
