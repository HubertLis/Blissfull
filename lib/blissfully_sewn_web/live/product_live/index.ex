defmodule BlissfullySewnWeb.ProductLive.Index do
  use BlissfullySewnWeb, :live_view

  alias BlissfullySewn.Products
  alias BlissfullySewn.Products.Product

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket) do
      Phoenix.PubSub.subscribe(BlissfullySewn.PubSub, "products")
    end
    socket
    |> assign(:uploaded_files, [])
    |> allow_upload(:image, accept: ~w(.jpg .jpeg .png), max_entries: 10)

    {:ok, stream(socket, :products, Products.list_products())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Product")
    |> assign(:product, Products.get_product!(id))
    |> assign(:component, BlissfullySewnWeb.ProductLive.Edit)
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Product")
    |> assign(:product, %Product{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Products")
    |> assign(:product, nil)
  end

  @impl true
  def handle_info({BlissfullySewnWeb.ProductLive.FormComponent, {:saved, product}}, socket) do
    {:noreply, stream_insert(socket, :products, product)}
#    {:noreply, socket}
  end

  def handle_info(:refresh, socket) do
    {:noreply, stream(socket, :products, Products.list_products(), reset: true)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    product = Products.get_product!(id)
    {:ok, _} = Products.delete_product(product)

    {:noreply, stream_delete(socket, :products, product)}
  end
end
