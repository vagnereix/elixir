defmodule Rockelivery.User do
  use Ecto.Schema

  import Ecto.Changeset

  alias Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}

  @required_params [:name, :email, :password, :cpf, :age, :cep, :address]

  @derive {Jason.Encoder, only: [:id, :name, :email]}

  schema "users" do
    field :address, :string
    field :age, :integer
    field :cep, :string
    field :cpf, :string
    field :email, :string
    field :password, :string, virtual: true
    field :password_hash, :string
    field :name, :string

    timestamps()
  end

  def changeset(params \\ %{}) do
    changeset(%__MODULE__{}, params)
  end

  def changeset(user, params) do
    user
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> unique_constraint(:cpf)
    |> unique_constraint(:email)
    |> validate_number(:age, greater_than_or_equal_to: 18)
    |> validate_length(:cep, min: 8)
    |> validate_length(:cpf, min: 11)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:password, min: 6, max: 100)
    |> put_password_hash()
  end

  defp put_password_hash(%Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Pbkdf2.add_hash(password))
  end

  defp put_password_hash(changeset), do: changeset
end
