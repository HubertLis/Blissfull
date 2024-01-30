defmodule BlissfullySewnWeb.TariffLive.Index do
  use BlissfullySewnWeb, :live_view

  alias BlissfullySewn.Vat
  alias BlissfullySewn.Vat.Tariff

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :vats, Vat.list_vats())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Tariff")
    |> assign(:tariff, Vat.get_tariff!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Tariff")
    |> assign(:tariff, %Tariff{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Vats")
    |> assign(:tariff, nil)
  end

  @impl true
  def handle_info({BlissfullySewnWeb.TariffLive.FormComponent, {:saved, tariff}}, socket) do
    {:noreply, stream_insert(socket, :vats, tariff)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    tariff = Vat.get_tariff!(id)
    {:ok, _} = Vat.delete_tariff(tariff)

    {:noreply, stream_delete(socket, :vats, tariff)}
  end
end
