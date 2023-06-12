defmodule LiveviewEcommerce.Carts.Cart do
  use Ecto.Schema
  import Ecto.Changeset

  schema "carts" do
    field(:quantity, :integer, default: 1)
    belongs_to(:user, LiveviewEcommerce.Users.User)
    belongs_to(:product, LiveviewEcommerce.Products.Product)

    timestamps()
  end

  @doc false
  def changeset(cart, attrs) do
    cart
    |> cast(attrs, [:quantity, :user_id, :product_id])
    |> validate_required([:quantity, :user_id, :product_id])
  end
end
