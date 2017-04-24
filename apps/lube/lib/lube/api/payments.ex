defmodule Lube.API.Payments do

  import Plug.Conn

  import Poison, only: [encode!: 1]


  # Prepare templates
  require EEx
  @base_dir File.cwd!()
  @template_dir Application.get_env(:lube, :template_dir)
  template = Path.join([@base_dir, @template_dir, "complete.html.eex"])
  EEx.function_from_file :defp, :redirect_template, template, []


  alias Lube.Storage

  alias Mollie.Payment
  alias Mollie.Payment.Request
  alias Mollie.Payment.Transaction

  def create(conn) do
    re=%Request{amount: 10.00, description: "CroMiDo lube Mollie test payment"}
    |> Payment.create

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
    |> send_resp(200, redirect_template())
  end
end
