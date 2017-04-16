defmodule Lube.Router do
  use Plug.Router

  plug :match
  plug Plug.Logger
  plug :dispatch

  # Perhaps restrict to dev environment only
  # plug Plug.Logger, log: :debug

  # Payment initialisation, referral, webhook, redirect
  import Lube.API.Payments, only: [create: 1, split: 1, finish: 1]
  get "/payments/create", do: create(conn)
  post "/payments/webhook", do: split(conn)
  get "/payments/redirect", do: finish(conn)

  # Home
  get "/" do
    conn
    |> put_resp_header("location", Application.get_env(:lube, :homepage))
    |> send_resp(303, "SEE OTHER")
  end

  # 404 Not Found
  match _, do: send_resp(conn, 404, "404 Not Found")
end
