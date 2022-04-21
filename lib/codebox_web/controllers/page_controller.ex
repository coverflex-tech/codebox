defmodule CodeboxWeb.PageController do
  use CodeboxWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
