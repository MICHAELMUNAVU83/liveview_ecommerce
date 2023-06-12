defmodule LiveviewEcommerceWeb.PageController do
  use LiveviewEcommerceWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
