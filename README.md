# ElixirDex

## Description

ElixirDex is Phoenix app which utilizes [Tesla](https://github.com/teamon/tesla) and [PokeApi](https://pokeapi.co/) to retrieve either a Pokemon name OR ID based on what you input.

If you input `Ditto`, you should get `132`, and if you input `139`, you should get `Omastar`. For nonexistent entities such as an ID or name not in PokeAPI, you should receive `Not Found`.

## Database Schema

## Local Setup

### Requirements
- Elixir installed
- Erlang installed
- PSQL installed
- 

### Commands to run prior to using program
- Run `mix deps.get` to match project dependencies.
- Run `mix ecto.create`, we have a psql DB involved.
  - This requires `config` files have matching `username` and `password` to your local DB. Please either change these attrs, or match your local DB to this.
- Run `mix test` in order to assert everything is working as planned. This requires having the Ecto step above to work.

### CLI Setup

In case you are having issues w/ local DB, you can still use the CLI interactions. You'll just run into DB error messages, irrelevant to how the program works.

To use the CLI Pokedex Interaction,
- Have your location be in root project directory
- Run in your Terminal: `mix escript.build`
- You should see in the Root Directory a new file called `elixir_dex`
- To run this script, input into your Terminal: `./elixir_dex {POKEMON ID OR NAME}`
  - Please input all lower case name.
  - Please input an existing Pokemon Name or ID
    - Program will try to account for whitespaces or capital letters
  - Terminal examples:
    - Input: `./elixir_dex ditto`
      - Output: `132`
    - Input: `./elixir_dex 1`
      - Output: `bulbasaur`
    - Input: `./elixir_dex 1000000`
      - Output: `Not Found`

### Windows Instructions:
- Follow every step above until you have a geenrated `elixir_dex` script in your project directory
- Instead of running `./elixir_dex {POKEMON ID OR NAME}`, remove the `.`.
  - Ex: `elixir_dex {POKEMON ID OR NAME}`