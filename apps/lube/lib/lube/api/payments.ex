defmodule Lube.API.Payments do

  import Plug.Conn

  import Poison, only: [encode!: 1]

  alias Lube.Templates

  alias Lube.Storage

  alias Mollie.Payment
  alias Mollie.Payment.Request
  alias Mollie.Payment.Transaction

  import Fuelpump.Messages

  def create(conn) do
    re=%Request{amount: 10.00, description: "CroMiDo lube Mollie test payment"}
    |> Payment.create

    case re do
      {:ok, t=%Transaction{links: %{"paymentUrl" => url}}} ->
        Storage.write!(t)
        # Prepare Chatfuel response
        buttons = buttons("Cool, I've prepared a €10.00 top-up. Ready to go to the check-out?")
        |> add_web_url_button("Let's go", url)
        |> add_show_block_button("Cancel", "Cancel")
        messages = messages()
        |> add_attachment(buttons)
        # Respond on conn
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(200, encode! messages)

      {:error, error} ->
        IO.inspect error
        # Return a neat error message
        conn
        |> send_resp(500, "INTERNAL SERVER ERROR")
    end
  end

  def webhook(conn=%{params: %{"id" => id}}) do
    case Payment.get(%Transaction{id: id}) do
      {:ok, t=%Transaction{}} ->
        Storage.write!(t)

        # Send payment status update to the user (chatbot)

        conn
        |> send_resp(200, "OK")

      {:error, error} ->
        IO.inspect error
        # Return a neat error message
        conn
        |> send_resp(500, "INTERNAL SERVER ERROR")
    end
  end

  def redirect(conn) do
    # Thanks for all the fish; allow to dismiss the screen
    conn
    |> put_resp_content_type("text/html")
    |> send_resp(200, Templates.redirect())
  end
end
