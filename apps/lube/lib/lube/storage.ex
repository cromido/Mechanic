defmodule Lube.Storage do

  alias Stash.Registry
  alias Stash.Bucket

  alias Mollie.Transaction

  # Read/write Transactions
  def read(%Transaction{id: key}), do: read(:transaction, key)
  def write!(value=%Transaction{id: key}), do: write!(:transaction, key, value)

  # Read/write Users

  defp read(table, key) do
    Registry.lookup!(table)
    |> Bucket.get(key)
  end

  defp write!(table, key, value) do
    Registry.lookup!(table)
    |> Bucket.set(key, value)
  end

end
