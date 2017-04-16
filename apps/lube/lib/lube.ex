defmodule Lube do
  @moduledoc """
  Documentation for Lube.
  """

  use Application
  require Logger

  def start(_type, _args) do
    children = [
      Plug.Adapters.Cowboy.child_spec(:http, Lube.Router, [], port: port())
    ]

    Logger.info "Started application"

    Supervisor.start_link(children, strategy: :one_for_one)
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
