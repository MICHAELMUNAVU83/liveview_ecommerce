defmodule LiveviewEcommerce.Products.Product do
  use Ecto.Schema
  import Ecto.Changeset

  schema "products" do
    field :name, :string
    field :price, :integer
    field :images, {:array, :string}, default: []
    has_many(:carts, LiveviewEcommerce.Carts.Cart)

    timestamps()
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:name, :price, :images])
    |> validate_required([:name, :price, :images])
  end
end
