defmodule Lube do
  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  require Logger

  def start(type, _args) do
    import Supervisor.Spec, warn: false

    # Create buckets in my Stash registry to store user and transaction data
    Stash.Registry.create(:user)
    Stash.Registry.create(:transaction)

    # Define workers and child supervisors to be supervised
    children = [
      # Starts a worker by calling: Fuelpump.Worker.start_link(arg1, arg2, arg3)
      # worker(Fuelpump.Worker, [arg1, arg2, arg3]),
      Plug.Adapters.Cowboy.child_spec(:http, Lube.Router, [], port: port())
    ]

    Logger.info "Application Lube started: #{type}"

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Lube.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp port do
    case System.get_env("PORT") do
      nil ->
        8080
      str ->
        try do
          String.to_integer(str)
        rescue
          ArgumentError ->
            8080
        end
    end
  end

end
