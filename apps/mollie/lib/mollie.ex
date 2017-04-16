defmodule Mollie do

  @base_url   Application.get_env(:mollie, :base_url)
  @api_key    Application.get_env(:mollie, :api_key)

  # Headers as follows:
  #   -H "Authorization: Bearer test_dHar4XY7LxsDOtmnkVtjNVWXLSlXsM"
  @headers    [{"Authorization", "Bearer " <> @api_key} ]

  alias HTTPoison, as: Http
  import Poison, only: [encode!: 1, decode!: 1]

  alias Mollie.Payment

  def post(params=%Payment{}) do
    payload = encode!(params)
    case Http.post(@base_url <> "/payments", payload, @headers) do
      {:ok, %Http.Response{status_code: 201, body: body}} ->                    # HTTP 201 CREATED
        {:ok, decode! body}
      {:ok, %Http.Response{status_code: 422, body: body}} ->                    # HTTP 422 UNPROCESSABLE ENTITY
        {:error, decode! body}
      {:error, %Http.Error{reason: reason}} ->
        {:error, reason}
    end
  end

end
