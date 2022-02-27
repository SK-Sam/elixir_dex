# ElixirDex

## Description

ElixirDex is Phoenix app which utilizes [Tesla](https://github.com/teamon/tesla) and [PokeApi](https://pokeapi.co/) to retrieve either a Pokemon name OR ID based on what you input.

If you input `Ditto`, you should get `132`, and if you input `139`, you should get `Omastar`. For nonexistent entities such as an ID or name not in PokeAPI, you should receive `Not Found`.

## Endpoints

## Database Schema

## API Contract

## Local Setup

To start your Phoenix server:

  * Setup the project with `mix setup`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.
