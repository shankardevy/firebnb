defmodule FirebnbWeb.PageController do
  use FirebnbWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
