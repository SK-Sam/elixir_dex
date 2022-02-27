defmodule ElixirDex.Pokedex.DataFetcher do
  alias ElixirDex.Pokedex.DataCleaner
  alias ElixirDex.Pokedex.Validations

  @moduledoc """
  A Pokedex must be able to fetch data from some sort of central database. This
  module handles situations such that the Trainer is in a forest, ocean, etc. and
  can scan a Pokemon by ID or Name at any given moment, and be able to receive data
  about inputted Pokemon.
  """

  @spec pokemon_name_or_id(Tesla.Client.t(), String.t()) :: String.t()
  def pokemon_name_or_id(client, input) do
    with {:ok, _} <- Validations.maybe_add_errors(input),
         cleaned_input <- DataCleaner.clean_data(input),
         {:ok,
          %Tesla.Env{
            status: 200,
            body: %{
              "name" => name,
              "id" => id
            }
          }} <- pokemon_api_response(client, cleaned_input) do
      choose_name_or_id(id, name, cleaned_input)
    else
      {:error, _} -> "Incorrect Format"
      _ -> "Not Found"
    end
  end

  @doc """
  pokemon_api_response hits the Pokemon API Pokemon Endpoint and simply
  returns the entire response.
  """
  @spec pokemon_api_response(Tesla.Client.t(), String.t()) :: tuple()
  def pokemon_api_response(client, input) do
    Tesla.get(client, "/pokemon/" <> input)
  end

  @doc """
  If input is a number as String, return name, otherwise return id
  """
  @spec choose_name_or_id(String.t(), String.t(), String.t()) :: String.t()
  def choose_name_or_id(id, name, input) do
    case is_id?(input) do
      true -> name
      false -> id
    end
  end

  @doc """
  Decide if input is an id based on if Integer.parse returns a tuple
  with an empty string. The empty string informs us of a proper parsing.
  """
  @spec is_id?(String.t()) :: boolean()
  def is_id?(input) do
    case Integer.parse(input) do
      {_number, ""} -> true
      _ -> false
    end
  end

  @spec client :: Tesla.Client.t()
  def client do
    [
      {Tesla.Middleware.BaseUrl, "https://pokeapi.co/api/v2"},
      Tesla.Middleware.JSON
    ]
    |> Tesla.client()
  end
end
