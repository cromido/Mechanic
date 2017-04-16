defmodule Lube.HelloWorld do
  import Plug.Conn

  def hello_world(conn) do
    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(200, "Hello, World!")
  end

end
