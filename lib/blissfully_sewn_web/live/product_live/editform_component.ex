defmodule BlissfullySewnWeb.ProductLive.Edit do
  alias BlissfullySewn.Colors
  alias BlissfullySewn.Sizes
  use BlissfullySewnWeb, :live_component
  alias BlissfullySewn.Products


  @impl true
  def render(assigns) do
    color_options =
      Colors.list_colors()
      |> Enum.map(&{&1.name, &1.id})

    size_options =
      Sizes.list_size()
      |> Enum.map(&{&1.name, &1.id})

    assigns = Map.put(assigns, :color_options, color_options)
    assigns = Map.put(assigns, :size_options, size_options)

    ~H"""
    <div>
    <head>
    </head>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage product records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="product-form"
        phx-target={@myself}
        phx-submit="save"
      >
        <.input field={@form[:name]} type="text" label="Name *" />
        <.input field={@form[:price]} type="number" label="Price *" step="any" />
        <.input
        field={@form[:color_id]}
        type="checkgroup"
        label="Colors"
        multiple={true}
        options={@color_options}
        />
        <.input
        field={@form[:size_id]}
        type="checkgroup2"
        label="Sizes"
        multiple={true}
        options={@size_options}
        />
        <label>Description</label>
        <.input field={@form[:description]} type="text" label="Description" />
        <div class="upload-title"><strong>Main Image (Front Page Image)</strong></div>
        <.live_file_input upload={@uploads.mainimage}/>
        <%= for entry <- @uploads.mainimage.entries do %>
          <article class="upload-entry">
            <figure>
              <.live_img_preview entry={entry} />
              <figcaption><%= entry.client_name %></figcaption>
            </figure>

            <%!-- entry.progress will update automatically for in-flight entries --%>
            <progress value={entry.progress} max="100"><%= entry.progress %>%</progress>

            <%!-- a regular click event whose handler will invoke Phoenix.LiveView.cancel_upload/3 --%>
            <button
              type="button"
              phx-click="cancel-upload"
              phx-value-ref={entry.ref}
              aria-label="cancel"
            >
              &times;
            </button>

            <%!-- Phoenix.Component.upload_errors/2 returns a list of error atoms --%>
            <%= for err <- upload_errors(@uploads.mainimage, entry) do %>
              <p class="alert alert-danger"><%= error_to_string(err) %></p>
            <% end %>
          </article>
        <% end %>
        <div class="upload-title">Additional Images</div>
        <.live_file_input upload={@uploads.additionalimage} />
        <%= for entry <- @uploads.additionalimage.entries do %>
          <article class="upload-entry">
            <figure>
              <.live_img_preview entry={entry} />
              <figcaption><%= entry.client_name %></figcaption>
            </figure>

            <%!-- entry.progress will update automatically for in-flight entries --%>
            <progress value={entry.progress} max="100"><%= entry.progress %>%</progress>

            <%!-- a regular click event whose handler will invoke Phoenix.LiveView.cancel_upload/3 --%>
            <button
              type="button"
              phx-click="cancel-upload"
              phx-value-ref={entry.ref}
              aria-label="cancel"
            >
              &times;
            </button>

            <%!-- Phoenix.Component.upload_errors/2 returns a list of error atoms --%>
            <%= for err <- upload_errors(@uploads.additionalimage, entry) do %>
              <p class="alert alert-danger"><%= error_to_string(err) %></p>
            <% end %>
          </article>
        <% end %>
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
  def mount(socket) do
    {:ok,
     socket
     |> assign(:uploaded_files, [])
     |> allow_upload(:mainimage, accept: ~w(.png), max_entries: 1, auto_upload: true)
     |> allow_upload(:additionalimage, accept: ~w(.png), max_entries: 5, auto_upload: true)}
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

  defp upload_files(socket, product) do
    directory = Path.join(Application.app_dir(:blissfully_sewn, "priv/static/uploads"), "#{product.id}")
    File.mkdir_p!(directory)
    main_image_upload =
      consume_uploaded_entries(socket, :mainimage, fn %{path: path}, _entry ->
        dest = Path.join(directory, "main.png")
        File.cp!(path, dest)
        {:ok, ~p"/uploads/#{product.id}/main.png"}
      end)
    consume_uploaded_entries(socket, :additionalimage, fn %{path: path}, _entry ->
      random_uuid = UUID.uuid1()
      dest = Path.join(directory, "#{random_uuid}.png")
      File.cp!(path, dest)
    end)
    update(socket, :uploaded_files, &(&1 ++ main_image_upload))
  end

  defp save_product(socket, :edit, product_params) do
    case Products.update_product(socket.assigns.product, product_params) do
      {:ok, product} ->
        notify_parent({:saved, product})

        {:noreply,
         socket
         |> upload_files(product)
         |> put_flash(:info, "Product updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  def error_to_string(:too_large), do: "Too large"
  def error_to_string(:not_accepted), do: "You have selected an unacceptable file type"

  # defp notify_parent(_), do: Phoenix.PubSub.broadcast(BlissfullySewn.PubSub, "products", :refresh)
  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
