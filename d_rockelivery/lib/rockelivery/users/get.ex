defmodule Rockelivery.Users.Get do
  alias Ecto.UUID
  alias Rockelivery.{Error, Repo, User}

  def by_id(id) do
    case UUID.cast(id) do
      :error -> {:error, Error.build_invalid_uuid()}
      {:ok, _} -> get(id)
    end
  end

  defp get(id) do
    case Repo.get(User, id) do
      nil -> {:error, Error.build_user_not_found()}
      user -> {:ok, user}
    end
  end
end
