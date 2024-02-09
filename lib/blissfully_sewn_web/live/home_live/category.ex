defmodule BlissfullySewnWeb.HomeLive.Categories do
  use BlissfullySewnWeb, :live_view

  alias BlissfullySewn.Products
  alias BlissfullySewn.Categories

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"category_name" => category_name}, _, socket) do
    category = BlissfullySewn.Categories.get_category_by_name!(category_name)
    {:noreply,
     assign(socket,
       page_title: page_title(socket.assigns.live_action),
       category: category)}
  end

  defp page_title(:category), do: "Show Product"
  defp page_title(:edit), do: "Edit Product"
end
