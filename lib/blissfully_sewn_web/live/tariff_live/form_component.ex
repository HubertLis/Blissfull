defmodule BlissfullySewnWeb.TariffLive.FormComponent do
  use BlissfullySewnWeb, :live_component

  alias BlissfullySewn.Vat

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage tariff records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="tariff-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:vat]} type="number" label="Vat" step="any" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Tariff</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{tariff: tariff} = assigns, socket) do
    changeset = Vat.change_tariff(tariff)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"tariff" => tariff_params}, socket) do
    changeset =
      socket.assigns.tariff
      |> Vat.change_tariff(tariff_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"tariff" => tariff_params}, socket) do
    save_tariff(socket, socket.assigns.action, tariff_params)
  end

  defp save_tariff(socket, :edit, tariff_params) do
    case Vat.update_tariff(socket.assigns.tariff, tariff_params) do
      {:ok, tariff} ->
        notify_parent({:saved, tariff})

        {:noreply,
         socket
         |> put_flash(:info, "Tariff updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_tariff(socket, :new, tariff_params) do
    case Vat.create_tariff(tariff_params) do
      {:ok, tariff} ->
        notify_parent({:saved, tariff})

        {:noreply,
         socket
         |> put_flash(:info, "Tariff created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
