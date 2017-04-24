# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

# This configuration is loaded before any dependency and is restricted
# to this project. If another project depends on this project, this
# file won't be loaded nor affect the parent project. For this reason,
# if you want to provide default values for your application for
# 3rd-party users, it should be done in your "mix.exs" file.

# By default, the umbrella project as well as each child
# application will require this configuration file, ensuring
# they all use the same configuration. While one could
# configure all applications here, we prefer to delegate
# back to each application for organization purposes.
import_config "../apps/*/config/config.exs"

# You can configure for your application as:
#
#     config :lube, key: :value
#
# And access this configuration in your application as:
#
#     Application.get_env(:lube, :key)
#
# Or configure a 3rd-party app:
#
#     config :logger, level: :info
#

config :lube, homepage: "https://www.cromido.org"

config :mollie, [
  base_url: "https://api.mollie.nl/v1",
  redirect_url: "https://cromido-lube.herokuapp.com/payments/redirect",
  webhook_url: "https://cromido-lube.herokuapp.com/payments/webhook"
]

# It is also possible to import configuration files, relative to this
# directory. For example, you can emulate configuration per environment
# by uncommenting the line below and defining dev.exs, test.exs and such.
# Configuration from the imported file will override the ones defined
# here (which is why it is important to import them last).
#
import_config "#{Mix.env}.exs"
