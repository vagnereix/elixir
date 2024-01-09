defmodule RockeliveryWeb.UsersController do
  use RockeliveryWeb, :controller

  alias Rockelivery.User
  alias RockeliveryWeb.FallbackController

  action_fallback FallbackController

  def create(conn, params) do
    with {:ok, %User{} = user} <- Rockelivery.create_user(params) do
      conn
      |> put_status(:created)
      |> render(:created, user: user)

      # |> put_view(RockeliveryWeb.UserView) is unnecessary because we are
      # using the same name for the controller and the view
    end
  end

  def delete(conn, %{"id" => id}) do
    with {:ok, %User{}} <- Rockelivery.delete_user(id) do
      conn
      |> put_status(:no_content)
      |> send_resp(:no_content, "")
    end
  end

  def update(conn, params) do
    with {:ok, %User{} = user} <- Rockelivery.update_user(params) do
      conn
      |> put_status(:ok)
      |> render(:show, user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    with {:ok, %User{} = user} <- Rockelivery.get_user_by_id(id) do
      conn
      |> put_status(:ok)
      |> render(:show, user: user)
    end
  end
end
