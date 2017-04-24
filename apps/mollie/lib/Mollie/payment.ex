defmodule Mollie.Payment do

  @base_url   Application.get_env(:mollie, :base_url)
  @api_key    Application.get_env(:mollie, :api_key)

  # Headers as follows:
  #   -H "Authorization: Bearer test_dHar4XY7LxsDOtmnkVtjNVWXLSlXsM"
  @headers    [{"Authorization", "Bearer " <> @api_key} ]

  alias HTTPoison, as: Http
  import Poison, only: [encode!: 1, decode!: 1, decode!: 2]

  alias Mollie.Payment.Request
  alias Mollie.Payment.Transaction

  def create(req=%Request{}) do
    case Http.post(@base_url <> "/payments", encode!(req), @headers) do
      {:ok, %Http.Response{status_code: 201, body: body}} ->                    # HTTP 201 CREATED
        {:ok, decode!(body, as: %Transaction{})}

      {:ok, %Http.Response{status_code: 422, body: body}} ->                    # HTTP 422 UNPROCESSABLE ENTITY
        {:error, decode! body}

      {:error, %Http.Error{reason: reason}} ->
        {:error, reason}
    end
  end

  def get(_t=%Transaction{id: id}) do
    case Http.get(@base_url <> "/payments" <> "/#{id}", @headers, params: %{testmode: true}) do
      {:ok, %Http.Response{status_code: 200, body: body}} ->                    # HTTP 200 OK
        {:ok, decode!(body, as: %Transaction{})}

      {:ok, %Http.Response{status_code: 404, body: body}} ->                    # HTTP 404 NOT FOUND
        {:error, decode! body}

      {:error, %Http.Error{reason: reason}} ->
        {:error, reason}
    end
  end

  def get(_t=%Transaction{id: id}, f) do
    # Apply response to f
  end

end
