defmodule BlissfullySewnWeb.HomeLive.Index do

  use BlissfullySewnWeb, :live_view
  alias BlissfullySewn.Categories
  alias BlissfullySewn.Products

  @impl true

  def mount(_params, _session, socket) do
    categories_with_products = Categories.list_categories_with_products()
    categories = Categories.list_categories() # Adjust this line to match your actual function for fetching categories
    products = Products.list_products()       # Similarly, adjust this line as necessary
    {:ok, assign(socket, categories: categories, products: products, page_title: "kekw", categories_with_products: categories_with_products)}
  end





  @impl true
  def handle_event("toggle_category_menu", _params, socket) do
    new_assigns = toggle_category_menu_visibility(socket.assigns)
    {:noreply, assign(socket, new_assigns)}
  end

  defp toggle_category_menu_visibility(assigns) do
    # This function toggles the visibility state of the category menu.
    # It checks if `:show_category_menu` is already in the assigns and toggles its boolean value.
    show_category_menu = Map.get(assigns, :show_category_menu, false)
    Map.put(assigns, :show_category_menu, !show_category_menu)
  end

  @impl true

  def handle_params(_params, _uri, socket) do

    {:noreply, socket}

  end

end
