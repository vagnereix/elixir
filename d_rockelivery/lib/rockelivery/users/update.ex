defmodule Rockelivery.Users.Update do
  alias Rockelivery.{Error, Repo, User}
  alias Rockelivery.Users.Get

  alias Ecto.UUID

  def call(%{"id" => id} = params) do
    case UUID.cast(id) do
      :error -> {:error, Error.build_invalid_uuid()}
      {:ok, _} -> update(params)
    end
  end

  defp update(%{"id" => id} = params) do
    case Get.by_id(id) do
      {:error, result} -> {:error, result}
      {:ok, user} -> make_changeset(user, params)
    end
  end

  defp make_changeset(%User{} = user, params) do
    user
    |> User.changeset(params)
    |> Repo.update()
  end
end
