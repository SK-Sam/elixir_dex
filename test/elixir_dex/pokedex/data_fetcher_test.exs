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

  describe "pokemon_api_response/2" do
    test "receive entire http response" do
      client = DataFetcher.client()

      assert {:ok, %Tesla.Env{} = env} = DataFetcher.pokemon_api_response(client, "ditto")
      assert env.status == 200
      assert env.body == %{"name" => "dittoe", "id" => "1"}

      assert {:ok, %Tesla.Env{} = env} = DataFetcher.pokemon_api_response(client, "10000")
      assert env.status == 404
    end
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

  describe "is_id?/1" do
    test "decides if input is an id or not based on how input is Integer.parse'd." do
      id = "132"
      name = "ditto"
      mixed_id_name_1 = "123ditto"
      mixed_id_name_2 = "123 ditto"

      assert DataFetcher.is_id?(id)
      refute DataFetcher.is_id?(name)
      refute DataFetcher.is_id?(mixed_id_name_1)
      refute DataFetcher.is_id?(mixed_id_name_2)
    end
  end

  describe "choose_name_or_id/3" do
    test "will decide to return a name or id based on if input is considered id or name" do
      id = "132"
      name = "ditto"

      assert DataFetcher.choose_name_or_id(id, name, id) == name
      assert DataFetcher.choose_name_or_id(id, name, name) == id
    end
  end
end
