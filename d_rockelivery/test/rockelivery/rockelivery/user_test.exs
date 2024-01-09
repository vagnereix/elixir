defmodule Rockelivery.Rockelivery.UserTest do
  use Rockelivery.DataCase

  alias Rockelivery.Rockelivery.User

  describe "exemplos" do
    alias Rockelivery.Rockelivery.User.Exemplo

    import Rockelivery.Rockelivery.UserFixtures

    @invalid_attrs %{nome: nil, idade: nil}

    test "list_exemplos/0 returns all exemplos" do
      exemplo = exemplo_fixture()
      assert User.list_exemplos() == [exemplo]
    end

    test "get_exemplo!/1 returns the exemplo with given id" do
      exemplo = exemplo_fixture()
      assert User.get_exemplo!(exemplo.id) == exemplo
    end

    test "create_exemplo/1 with valid data creates a exemplo" do
      valid_attrs = %{nome: "some nome", idade: 42}

      assert {:ok, %Exemplo{} = exemplo} = User.create_exemplo(valid_attrs)
      assert exemplo.nome == "some nome"
      assert exemplo.idade == 42
    end

    test "create_exemplo/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = User.create_exemplo(@invalid_attrs)
    end

    test "update_exemplo/2 with valid data updates the exemplo" do
      exemplo = exemplo_fixture()
      update_attrs = %{nome: "some updated nome", idade: 43}

      assert {:ok, %Exemplo{} = exemplo} = User.update_exemplo(exemplo, update_attrs)
      assert exemplo.nome == "some updated nome"
      assert exemplo.idade == 43
    end

    test "update_exemplo/2 with invalid data returns error changeset" do
      exemplo = exemplo_fixture()
      assert {:error, %Ecto.Changeset{}} = User.update_exemplo(exemplo, @invalid_attrs)
      assert exemplo == User.get_exemplo!(exemplo.id)
    end

    test "delete_exemplo/1 deletes the exemplo" do
      exemplo = exemplo_fixture()
      assert {:ok, %Exemplo{}} = User.delete_exemplo(exemplo)
      assert_raise Ecto.NoResultsError, fn -> User.get_exemplo!(exemplo.id) end
    end

    test "change_exemplo/1 returns a exemplo changeset" do
      exemplo = exemplo_fixture()
      assert %Ecto.Changeset{} = User.change_exemplo(exemplo)
    end
  end
end
