# ElixirDex

## Description

ElixirDex is Phoenix app which utilizes [Tesla](https://github.com/teamon/tesla) and [PokeApi](https://pokeapi.co/) to retrieve either a Pokemon name OR ID based on what you input.

If you input `Ditto`, you should get `132`, and if you input `139`, you should get `omastar`. For nonexistent entities such as an ID or name not in PokeAPI, you should receive `Not Found`.

**We will do our best on the application side to account for extra whitespaces and capitalized letters, but please follow the format of inputting lowercase Pokemon names. We understand if you're currently running away from scary Pokemon and can't focus on typing.**

## Database Schema
`Pokemon` is the only Table in the DB, and is relatively straightforward.

A `Pokemon` should have fields of:
  - Name(String)
  - Pokedex ID(Integer)
  - Type(String)
  - Timestamps(Created & Updated)

We are validating for uniqueness of:
  - Name
  - Pokedex ID

This means we cannot have two `"ditto"` names in the Pokedex, nor can we have two `Pokemon` with an ID of `100`. We first run `unsafe_validate_unique/3` in order to throw an error prior to insertion, and have created a `unique index` on both attributes in case we somehow reach the DB with non-unique data. This extra layer of protection should defend us from any race conditions due to how `unsafe_validate_unique/3` works.

## Local Setup

### Requirements
- Elixir installed
- Erlang installed
- PSQL installed

### Commands to run prior to using program
- Run `mix deps.get` to match project dependencies.
- Run `mix ecto.create`, we have a psql DB involved.
  - This requires `config` files have matching `username` and `password` to your local DB. Please either change these attrs, or match your local DB to this.
- Run `mix test` in order to assert everything is working as planned. This requires having the Ecto step above to work.

### MacOS CLI Setup

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