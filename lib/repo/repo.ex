defmodule Repo do
  use Ecto.Repo,
    otp_app: :url,
    adapter: Ecto.Adapters.Postgres
end
