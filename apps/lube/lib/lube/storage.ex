defmodule Lube.Storage do

  require Logger

  alias Stash.Registry
  alias Stash.Bucket

  alias Mollie.Payment.Transaction

  # Read/write Transactions
  def read(%Transaction{id: key}), do: read(:transaction, key)
  def write!(value=%Transaction{id: key}), do: write!(:transaction, key, value)

  # Read/write Users

  defp read(table, key) do
    Registry.lookup!(table)
    |> Bucket.get(key)
  end

  defp write!(table, key, value) do
    Logger.info "Writing #{table} #{key}."
    Registry.lookup!(table)
    |> Bucket.set(key, value)
  end

end
