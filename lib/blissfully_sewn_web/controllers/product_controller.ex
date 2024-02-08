defmodule BlissfullySewnWeb.ProductController do
  use BlissfullySewnWeb, :controller
  alias BlissfullySewn.Products

  def show(conn, %{"product_id" => product_id}) do
    product = Products.get_product!(product_id)
    render(conn, "show.html", product: product)
  end
end
