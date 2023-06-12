defmodule LiveviewEcommerce.Repo.Migrations.CreateProducts do
  use Ecto.Migration

  def change do
    create table(:products) do
      add(:name, :string)
      add(:price, :integer)
      add(:images, {:array, :string}, default: [])
      

      timestamps()
    end
  end
end
