defmodule CExlivery.Users.CreateOrUpdate do
  alias CExlivery.Users.Agent, as: UserAgent
  alias CExlivery.Users.User

  def call(%{name: name, address: address, email: email, cpf: cpf, age: age}) do
    name
    |> User.build(email, cpf, age, address)
    |> save()
  end

  defp save({:ok, %User{} = user}) do
    UserAgent.save(user)
    {:ok, "User created or update successfully"}
  end

  defp save({:error, _} = error), do: error
end
