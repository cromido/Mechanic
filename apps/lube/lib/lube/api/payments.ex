defmodule Lube.API.Payments do
  import Plug.Conn

  import Poison, only: [encode!: 1]

  alias Lube.Storage

  alias Mollie
  alias Mollie.Payment
  alias Mollie.Transaction

  def create(conn) do
    re=%Payment{amount: 10.00, description: "CroMiDo lube Mollie test payment"}
    |> Mollie.post

    case re do
      {:ok, t=%Transaction{links: %{"paymentUrl" => url}}} ->
        Storage.write!(t)
        # Perhaps prepare EEX JSON responses?
        response = %{
          "messages" => [
            %{
              "attachment" => %{
                "type" => "template",
                "payload" => %{
                  "template_type" => "button",
                  "text" => "Cool, I've prepared a €10.00 top-up. Ready to go to the check-out?",
                  "buttons" => [
                    %{
                      "type": "web_url",
                      "url": url,
                      "title": "Let's go"
                    },
                    %{
                      "type": "show_block",
                      "block_name": "Cancel",
                      "title": "Cancel"
                    }
                  ]
                }
              }
            }
          ]
        }

        conn
        |> put_resp_header("location", url)
        |> send_resp(200, encode! response)

      {:error, error} ->
        IO.inspect error
        # Return a neat error message
        conn
        |> send_resp(500, "INTERNAL SERVER ERROR")
    end
  end

  def webhook(conn) do
    conn
    |> send_resp(200, "OK")
  end

  def redirect(conn) do
    conn
    |> send_resp(200, "OK")
  end
end
