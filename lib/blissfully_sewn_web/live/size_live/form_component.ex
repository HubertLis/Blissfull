defmodule BlissfullySewnWeb.SizeLive.FormComponent do
  use BlissfullySewnWeb, :live_component

  alias BlissfullySewn.Sizes

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage size records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="size-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Size</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{size: size} = assigns, socket) do
    changeset = Sizes.change_size(size)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"size" => size_params}, socket) do
    changeset =
      socket.assigns.size
      |> Sizes.change_size(size_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"size" => size_params}, socket) do
    save_size(socket, socket.assigns.action, size_params)
  end

  defp save_size(socket, :edit, size_params) do
    case Sizes.update_size(socket.assigns.size, size_params) do
      {:ok, size} ->
        notify_parent({:saved, size})

        {:noreply,
         socket
         |> put_flash(:info, "Size updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_size(socket, :new, size_params) do
    case Sizes.create_size(size_params) do
      {:ok, size} ->
        notify_parent({:saved, size})

        {:noreply,
         socket
         |> put_flash(:info, "Size created successfully")
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
