defmodule ElixirDex.Pokedex.Validations do
  @moduledoc """

  """

  def maybe_add_errors(input) when is_bitstring(input) do
    case String.length(input) do
      0 -> {:error, :empty_string}
      _ -> {:ok, input}
    end
  end
  def maybe_add_errors(_), do: {:error, :incorrect_format}
end
