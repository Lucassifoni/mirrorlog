defmodule Mirrorlog.Repo do
  use Ecto.Repo,
    otp_app: :mirrorlog,
    adapter: Ecto.Adapters.SQLite3
end
