defmodule LiveviewEcommerceWeb.ProductLive.Index do
  use LiveviewEcommerceWeb, :live_view

  alias LiveviewEcommerce.Products
  alias LiveviewEcommerce.Products.Product
  alias LiveviewEcommerce.Users
  alias LiveviewEcommerce.Carts

  @impl true
  def mount(_params, session, socket) do
    user = Users.get_user_by_session_token(session["user_token"])

    {:ok,
     socket
     |> assign(:products, list_products())
     |> assign(:user, user)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Product")
    |> assign(:product, Products.get_product!(id))
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
  def handle_event("delete", %{"id" => id}, socket) do
    product = Products.get_product!(id)
    {:ok, _} = Products.delete_product(product)

    {:noreply, assign(socket, :products, list_products())}
  end

  def handle_event("add_to_cart", %{"id" => id}, socket) do
    product = Products.get_product!(id)
    user = socket.assigns.user

    cart_params = %{
      user_id: user.id,
      product_id: product.id
    }

    Carts.create_cart(cart_params)

    {:noreply, redirect(socket, to: Routes.cart_index_path(socket, :index))}
  end

  defp list_products do
    Products.list_products()
  end
end
