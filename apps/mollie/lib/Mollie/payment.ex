defmodule Mollie.Payment do

  # The API specification for payment request objects can be found at
  # https://www.mollie.com/nl/docs/reference/payments/create
  #
  # Only :amount and :description are non-optional

  @redirectUrl  Application.get_env(:mollie, :redirect_url)
  @webhookUrl   Application.get_env(:mollie, :webhook_url)

  @derive [Poison.Encoder]
  defstruct [
    # Decimal - The amount in EURO that you want to charge, e.g. `100.00` if you
    #  would want to charge €100.00.
    :amount,

    # String - The description of the payment you're creating. This will be
    #   shown to the consumer on their card or bank statement when possible, and
    #   in any exports you generate. We recommend you use the order number so
    #   that you can always link the payment to the order. This is particulary
    #   useful for bookkeeping.
    :description,

    # String - The URL the consumer will be redirected to after the payment
    #   process. It could make sense for the redirectURL to contain a unique
    #   identifier – like your order ID – so you can show the right page
    #   referencing the order when the consumer returns.
    redirectUrl: @redirectUrl,                                                  # Take default from config

    # String - The URL the consumer will be redirected to after the payment
    #   process. It could make sense for the redirectURL to contain a unique
    #   identifier – like your order ID – so you can show the right page
    #   referencing the order when the consumer returns.
    webhookUrl: @webhookUrl,                                                    # Take default from config

    # String - Optional – Normally, a payment method selection screen is shown.
    #   However, when using this parameter, your customer will skip the
    #   selection screen and will be sent directly to the chosen payment method.
    #   The parameter enables you to fully integrate the payment method
    #   selection into your website, however note Mollie's country based
    #   conversion optimization is lost.
    # Possible values: `creditcard`, `sofort`, `ideal`, `mistercash`,
    #   `banktransfer`, `directdebit`, `paypal`, `bitcoin`, `podiumcadeaukaart`,
    #    `paysafecard`, `kbc`, `belfius`
    method: nil,

    # Object - Optional – Provide any data you like in JSON notation, and we
    #   will save the data alongside the payment. Whenever you fetch the payment
    #   with our API, we'll also include the metadata. You can use up to 1kB of
    #   JSON.
    metadata: nil,

    # String - Optional – Allow you to preset the language to be used in the
    #   payment screens shown to the consumer. When this parameter is not
    #   provided, the browser language will be used instead (which is usually
    #   more accurate). You can provide any ISO 15897 locale, but our payment
    #   screens currently only support the following languages:
    # Possible values: `en_US`, `de_DE`, `fr_FR`, `fr_BE`, `nl_NL`, `nl_BE`
    locale: nil,

    # String - Optional
    recurringType: nil,

    # String - Optional – The ID of the customer for whom the payment is being
    #   created.
    customerId: nil,

    # String - Optional – When creating recurring payments, a specific mandate
    #   ID may be supplied to indicate which of the consumer's accounts should
    #   be credited.
    mandateId: nil
  ]

end
