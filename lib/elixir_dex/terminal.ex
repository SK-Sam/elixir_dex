defmodule ElixirDex.Terminal do
  @moduledoc """
  This houses the "MAIN" project regarding the CLI interactions.
  """
  alias ElixirDex.Pokedex.DataFetcher

  def main([]) do
    IO.puts("Please input a Pokemon ID or Name to the Terminal.")
  end

  def main(argv) do
    user_input = List.first(argv)
    client = DataFetcher.client()

    IO.puts(DataFetcher.pokemon_name_or_id(client, user_input))
  end
end
