defmodule Lube.Router do
  use Plug.Router

  plug :match
  plug Plug.Logger
  plug Plug.Parsers, parsers: [:urlencoded]
  plug :dispatch

  # Perhaps restrict to dev environment only
  # plug Plug.Logger, log: :debug

  # Payment creation, webhook, redirect
  import Lube.API.Payments, only: [create: 1, webhook: 1, redirect: 1]
  post "/payments/create", do: create(conn)
  post "/payments/webhook", do: webhook(conn)
  get "/payments/redirect", do: redirect(conn)

  # Home
  get "/" do
    conn
    |> put_resp_header("location", Application.get_env(:lube, :homepage))
    |> send_resp(303, "See Other")
  end

  # 404 Not Found
  match _, do: send_resp(conn, 404, "404 Not Found")
end
