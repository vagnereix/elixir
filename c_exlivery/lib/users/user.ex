defmodule CExlivery.Users.User do
  @keys [:name, :email, :cpf, :age, :address]
  @enforce_keys @keys

  defstruct @keys

  def build(name, email, cpf, age, address) when age >= 18 do
    {
      :ok,
      %__MODULE__{
        name: name,
        email: email,
        cpf: cpf,
        age: age,
        address: address
      }
    }
  end

  def build(_, _, _, age, _) when age < 18, do: {:error, "User must be 18 years old or older"}
end
