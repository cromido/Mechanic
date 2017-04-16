defmodule Mollie.Payment do

  @redirectUrl  Application.get_env(:mollie, :redirect_url)
  @webhookUrl   Application.get_env(:mollie, :webhook_url)

  @derive [Poison.Encoder]
  defstruct [
    :amount,
    :description,
    redirectUrl: @redirectUrl,    # Take default from config
    webhookUrl: @webhookUrl       # Take default from config
  ]

end
