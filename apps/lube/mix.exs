defmodule Lube.Mixfile do
  use Mix.Project

  def project do
    [app: :lube,
     version: "0.1.0",
     build_path: "../../_build",
     config_path: "../../config/config.exs",
     deps_path: "../../deps",
     lockfile: "../../mix.lock",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [applications: [:cowboy, :logger, :plug, :httpoison],
     mod: {Lube.Application, []}]
  end

  # Dependencies can be Hex packages:
  #
  #   {:my_dep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:my_dep, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps, do: [
    {:cowboy, "~> 1.1.2"},
    {:plug, "~> 1.3.4"},
    {:poison, "~> 3.1.0"},
    {:httpoison, "~> 0.11.1"},
    {:mollie, in_umbrella: true}
  ]
end
