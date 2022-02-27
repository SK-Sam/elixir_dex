defmodule ElixirDexWeb.PageController do
  use ElixirDexWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
