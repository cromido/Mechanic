defmodule Mollie.Transaction do

  # {:ok,
  #  %{"amount" => "10.00", "createdDatetime" => "2017-04-23T07:05:20.0Z",
  #    "description" => "CroMiDo lube Mollie test payment", "details" => nil,
  #    "expiryPeriod" => "PT15M", "id" => "tr_VDAA44zxJT",
  #    "links" => %{"paymentUrl" => "https://www.mollie.com/payscreen/select-method/VDAA44zxJT",
  #      "redirectUrl" => "https://cromido-lube.herokuapp.com/payments/redirect",
  #      "webhookUrl" => "https://cromido-lube.herokuapp.com/payments/webhook"},
  #    "metadata" => nil, "method" => nil, "mode" => "test",
  #    "profileId" => "pfl_Cymn5q7zVz", "resource" => "payment",
  #    "status" => "open"}}

  defstruct [
    # String - Indicates the response contains a payment object.
    # Possible values: `payment`
    :resource,

    # String - The identifier uniquely referring to this payment. Mollie assigns
    #   this identifier randomly at payment creation time. For example
    #   `tr_7UhSN1zuXS`. Its ID will always be used by Mollie to refer to a
    #   certain payment.
    :id,

    # String - The mode used to create this payment. Mode determines whether a
    #   payment is real or a test payment.
    # Possible values: `live`, `test`
    :mode,

    # Datetime – The payment's date and time of creation, in ISO 8601 format.
    :createdDatetime,

    # String - The payment's status. Please refer to the page about statuses for
    #   more info about which statuses occur at what point.
    # Possible values: `open`, `cancelled`, `expired`, `failed`, `pending`,
    #   `paid`, `paidout`, `refunded`, `charged_back`
    :status,

    # Datetime - Optional – The date and time the payment became paid, in
    #   ISO 8601 format. Null is returned if the payment isn't completed (yet).
    :paidDatetime,

    # Datetime - Optional – The date and time the payment was cancelled, in
    #   ISO 8601 format. Null is returned if the payment isn't cancelled (yet).
    :cancelledDatetime,

    # Datetime - Optional – The date and time the payment was expired, in
    #   ISO 8601 format. Null is returned if the payment did not expire (yet).
    :expiredDatetime,

    # Duration - Optional – The time until the payment will expire in ISO 8601
    #   duration format.
    :expiryPeriod,

    # Decimal - The amount in EURO.
    :amount,

    # Decimal - Only available when refunds are available for this payment – The
    #   total amount in EURO that is already refunded. For some payment methods,
    #   this amount may be higher than the payment amount, for example to allow
    #   reimbursement of the costs for a return shipment to the consumer.
    :amountRefunded,

    # Decimal - Only available when refunds are available for this payment – The
    #   remaining amount in EURO that can be refunded.
    :amountRemaining,

    # String - A short description of the payment. The description will be shown
    #   on the consumer's bank or card statement when possible.
    :description,

    # String | Null - The payment method used for this payment, either forced on
    #   creation by specifying the method parameter, or chosen by the consumer
    #   our payment method selection screen.
    # Possile values: `creditcard`, `sofort`, `ideal`, `mistercash`,
    #   `banktransfer`, `directdebit`, `paypal`, `bitcoin`, `podiumcadeaukaart`,
    #   `paysafecard`, `kbc`, `belfius`
    :method,

    # Object | Null - The optional metadata you provided upon payment creation.
    #   Metadata can be used to link an order to a payment.
    :metadata,

    # String - Optional – The consumer's locale, either forced on creation by
    #   specifying the `locale` parameter, or detected by us during checkout.
    :locale,

    # String - Optional – The consumer's ISO 3166-1 alpha-2 country code,
    #   detected by us during checkout. For example: `BE`.
    :countryCode,

    # String - The identifier referring to the profile this payment was created
    #   on. For example, `pfl_QkEhN94Ba`.
    :profileId,

    # String - Optional – The identifier referring to the settlement this
    #   payment belongs to. For example, `stl_BkEjN2eBb`.
    :settlementId,

    # String - If a customer ID was specified upon payment creation, the ID will
    #   be available here as well.
    :customerId,

    # String - Only available for recurring payments.
    # Possible values: `first`, `recurring`, `null`
    :recurringType,

    # String - Only available for recurring payments – If the payment is a
    #   recurring payment, this field will hold the ID of the mandate used to
    #   authorize the recurring payment.
    :mandateId,

    # String - Only available for recurring payments – When implementing the
    #   Subscriptions API, any recurring charges resulting from the subscription
    #   will hold the ID of the subscription that triggered the payment.
    :subscriptionId,

    # Object - An object with several URLs important to the payment process.
    #   See: https://www.mollie.com/nl/docs/reference/payments/get
    :links,

    # Object | Null - A detail object with payment method specific values is
    #   available for certain payment methods. For more information, see:
    #   https://www.mollie.com/nl/docs/reference/payments/get#specific-details
    :details
  ]
end
