defmodule BlissfullySewnWeb.SizeLive.Index do
  use BlissfullySewnWeb, :live_view

  alias BlissfullySewn.Sizes
  alias BlissfullySewn.Sizes.Size

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :size_collection, Sizes.list_size())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Size")
    |> assign(:size, Sizes.get_size!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Size")
    |> assign(:size, %Size{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Size")
    |> assign(:size, nil)
  end

  @impl true
  def handle_info({BlissfullySewnWeb.SizeLive.FormComponent, {:saved, size}}, socket) do
    {:noreply, stream_insert(socket, :size_collection, size)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    size = Sizes.get_size!(id)
    {:ok, _} = Sizes.delete_size(size)

    {:noreply, stream_delete(socket, :size_collection, size)}
  end
end
