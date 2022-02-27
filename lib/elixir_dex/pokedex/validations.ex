defmodule ElixirDex.Pokedex.Validations do
  @moduledoc """
  Validations should handle logic which checks if the Trainer's input into the Pokedex
  can be used by the Pokemon API endpoint. If we have a good input, we signal to the
  Pokedex w/ an :ok, input tuple. Otherwise we pass an error tuple along with the reason
  as an atom.
  """

  @doc """
  Either signal to Pokedex that the input is valid, or pass an error tuple
  """
  @spec maybe_add_errors(any) :: {:error, :empty_string | :incorrect_format} | {:ok, String.t}
  def maybe_add_errors(input) when is_bitstring(input) do
    case String.length(input) do
      0 -> {:error, :empty_string}
      _ -> {:ok, input}
    end
  end

  def maybe_add_errors(_), do: {:error, :incorrect_format}
end
