defmodule RockeliveryWeb.FallbackController do
  use RockeliveryWeb, :controller

  import Ecto.Changeset, only: [traverse_errors: 2]

  alias Ecto.Changeset
  alias Rockelivery.Error

  def call(conn, {:error, %Error{status: status, result: changeset}}) do
    conn
    |> put_status(status)
    |> json(%{
      message: translate_errors(changeset)
    })
  end

  defp translate_errors(%Changeset{} = changeset) do
    traverse_errors(changeset, fn {msg, opts} ->
      Enum.reduce(opts, msg, fn {key, value}, acc ->
        String.replace(acc, "%{#{key}}", to_string(value))
      end)
    end)
  end

  defp translate_errors(changeset), do: changeset
end
