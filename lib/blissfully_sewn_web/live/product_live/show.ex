defmodule BlissfullySewnWeb.ProductLive.Show do
  use BlissfullySewnWeb, :live_view

  alias BlissfullySewn.Products
  alias BlissfullySewn.Products.Product

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:product, Products.get_product!(id))}
  end

  defp page_title(:show), do: "Show Product"
  defp page_title(:edit), do: "Edit Product"
end
