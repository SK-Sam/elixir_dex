defmodule ElixirDex.Pokedex.DataCleaner do
  @moduledoc """
  Inputs and outputs should be cleaned as we expect Trainers not to input
  names and ID's perfectly every single use. Trainer may be in tense situations
  such as running away from strong Pokemon, or in an icy cave and have other
  concerns outside of capitalizing and spacing characters.
  """

  @doc """
  Removes whitespace and downcases entire string
  """
  @spec clean_data(String.t) :: String.t | tuple()
  def clean_data(input) do
    input
    |> String.downcase()
    |> remove_whitespace()
  end

  @doc """
  This should focus on removing whitespaces of inputted strings. In the pipeline,
  Fn should expect a String arg, and will return a tuple error to raise awareness
  to Trainer in case of this odd situation.
  """
  @spec remove_whitespace(String.t) :: String.t | tuple()
  def remove_whitespace(input) when is_bitstring(input) do
    String.replace(input, " ", "")
  end
end
