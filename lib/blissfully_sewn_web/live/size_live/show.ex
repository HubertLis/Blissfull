defmodule BlissfullySewnWeb.SizeLive.Show do
  use BlissfullySewnWeb, :live_view

  alias BlissfullySewn.Sizes

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:size, Sizes.get_size!(id))}
  end

  defp page_title(:show), do: "Show Size"
  defp page_title(:edit), do: "Edit Size"
end
