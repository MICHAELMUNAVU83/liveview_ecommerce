defmodule LiveviewEcommerceWeb.CartLive.Index do
  use LiveviewEcommerceWeb, :live_view

  alias LiveviewEcommerce.Carts
  alias LiveviewEcommerce.Carts.Cart
  alias LiveviewEcommerce.Users

  @impl true
  def mount(_params, session, socket) do
    user = Users.get_user_by_session_token(session["user_token"])
    {:ok, socket |> assign(:carts, Carts.list_carts_by_user(user.id))}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Cart")
    |> assign(:cart, Carts.get_cart!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Cart")
    |> assign(:cart, %Cart{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Carts")
    |> assign(:cart, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    cart = Carts.get_cart!(id)
    {:ok, _} = Carts.delete_cart(cart)

    {:noreply, assign(socket, :carts, Carts.list_carts_by_user(socket.assigns.user.id))}
  end

  def handle_event("add", %{"id" => id}, socket) do
    cart = Carts.get_cart!(id)

    {:ok, _} = Carts.update_cart(cart, %{"quantity" => cart.quantity + 1})

    {:noreply,
     socket
     |> assign(:carts, Carts.list_carts_by_user(socket.assigns.user.id))}
  end

  def handle_event("subtract", %{"id" => id}, socket) do
    cart = Carts.get_cart!(id)

    if cart.quantity > 1 do
      {:ok, _} = Carts.update_cart(cart, %{"quantity" => cart.quantity - 1})
    end

    {:noreply,
     socket
     |> assign(:carts, Carts.list_carts_by_user(socket.assigns.user.id))}
  end

  defp list_carts do
    Carts.list_carts()
  end
end
