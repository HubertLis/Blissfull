defmodule BlissfullySewnWeb.TariffLive.Show do
  use BlissfullySewnWeb, :live_view

  alias BlissfullySewn.Vat

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:tariff, Vat.get_tariff!(id))}
  end

  defp page_title(:show), do: "Show Tariff"
  defp page_title(:edit), do: "Edit Tariff"
end
