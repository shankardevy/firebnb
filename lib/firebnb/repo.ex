defmodule Firebnb.Repo do
  use Ecto.Repo,
    otp_app: :firebnb,
    adapter: Ecto.Adapters.Postgres
end
