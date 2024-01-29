defmodule BlissfullySewnWeb.ProductLive.FormComponent do
  alias BlissfullySewn.Colors
  alias BlissfullySewn.Sizes
  use BlissfullySewnWeb, :live_component
  alias BlissfullySewn.Products

  @impl true
  def render(assigns) do
    color_options =
      Colors.list_colors()
      |> Enum.map( & {&1.name, &1.id})
    size_options =
      Sizes.list_size()
      |> Enum.map( & {&1.name, &1.id})
    assigns = Map.put(assigns, :color_options, color_options)
    assigns = Map.put(assigns, :size_options, size_options)


    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage product records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="product-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name" />
        <.input field={@form[:price]} type="number" label="Price" step="any" />
        <.input field={@form[:vat]} type="number" label="Vat" />
        <.input field={@form[:color_id]} type="select" label="Color" options={@color_options} prompt="Choose the color" />
        <.input field={@form[:size_id]} type="select" label="Size" options={@size_options} prompt="Choose the size" />
        <.input field={@form[:size]} type="number" label="Size" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Product</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end


  @impl true
  def update(%{product: product} = assigns, socket) do
    changeset = Products.change_product(product)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"product" => product_params}, socket) do
    changeset =
      socket.assigns.product
      |> Products.change_product(product_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"product" => product_params}, socket) do
    save_product(socket, socket.assigns.action, product_params)
  end

  defp save_product(socket, :edit, product_params) do
    case Products.update_product(socket.assigns.product, product_params) do
      {:ok, product} ->
        notify_parent({:saved, product})

        {:noreply,
         socket
         |> put_flash(:info, "Product updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_product(socket, :new, product_params) do
    case Products.create_product(product_params) do
      {:ok, product} ->
        notify_parent({:saved, product})

        {:noreply,
         socket
         |> put_flash(:info, "Product created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  #defp notify_parent(_), do: Phoenix.PubSub.broadcast(BlissfullySewn.PubSub, "products", :refresh)
  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})

end
