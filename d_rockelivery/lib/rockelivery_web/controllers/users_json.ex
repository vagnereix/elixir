defmodule RockeliveryWeb.UsersJSON do
  alias Rockelivery.User

  def index(%{users: users}) do
    %{data: for(user <- users, do: data(user))}
  end

  def show(%{user: user}) do
    %{data: data(user)}
  end

  def created(%{user: user}) do
    %{
      message: "User created successfully",
      data: data(user)
    }
  end

  defp data(%User{} = user) do
    user
  end
end
