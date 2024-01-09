defmodule Rockelivery.Rockelivery.UserFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Rockelivery.Rockelivery.User` context.
  """

  @doc """
  Generate a exemplo.
  """
  def exemplo_fixture(attrs \\ %{}) do
    {:ok, exemplo} =
      attrs
      |> Enum.into(%{
        nome: "some nome",
        idade: 42
      })
      |> Rockelivery.Rockelivery.User.create_exemplo()

    exemplo
  end
end
