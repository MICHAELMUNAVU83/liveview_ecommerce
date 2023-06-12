defmodule LiveviewEcommerce.Repo do
  use Ecto.Repo,
    otp_app: :liveview_ecommerce,
    adapter: Ecto.Adapters.Postgres
end
