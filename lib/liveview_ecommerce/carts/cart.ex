defmodule LiveviewEcommerce.Carts.Cart do
  use Ecto.Schema
  import Ecto.Changeset

  schema "carts" do
    field :quantity, :integer, default: 1
    field :user_id, :id
    field :product_id, :id

    timestamps()
  end

  @doc false
  def changeset(cart, attrs) do
    cart
    |> cast(attrs, [:quantity, :user_id, :product_id])
    |> validate_required([:quantity, :user_id, :product_id])
  end
end