defmodule BlissfullySewnWeb.SearchController do
  use BlissfullySewnWeb, :controller
  alias BlissfullySewn.Products

  def index(conn, %{"query" => query}) do
    products = Products.search_products(query)

    render(conn, "home.html", products: products)
  end
end
