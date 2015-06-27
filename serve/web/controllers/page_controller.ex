defmodule Serve.PageController do
  use Serve.Web, :controller

  plug :action

  def index(conn, _params) do
    render conn, "index.html"
  end
end
