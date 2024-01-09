defmodule RockeliveryWeb.ExemploControllerTest do
  use RockeliveryWeb.ConnCase

  import Rockelivery.Rockelivery.UserFixtures

  alias Rockelivery.Rockelivery.User.Exemplo

  @create_attrs %{
    nome: "some nome",
    idade: 42
  }
  @update_attrs %{
    nome: "some updated nome",
    idade: 43
  }
  @invalid_attrs %{nome: nil, idade: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all exemplos", %{conn: conn} do
      conn = get(conn, ~p"/api/exemplos")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create exemplo" do
    test "renders exemplo when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/exemplos", exemplo: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/exemplos/#{id}")

      assert %{
               "id" => ^id,
               "idade" => 42,
               "nome" => "some nome"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/exemplos", exemplo: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update exemplo" do
    setup [:create_exemplo]

    test "renders exemplo when data is valid", %{conn: conn, exemplo: %Exemplo{id: id} = exemplo} do
      conn = put(conn, ~p"/api/exemplos/#{exemplo}", exemplo: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/exemplos/#{id}")

      assert %{
               "id" => ^id,
               "idade" => 43,
               "nome" => "some updated nome"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, exemplo: exemplo} do
      conn = put(conn, ~p"/api/exemplos/#{exemplo}", exemplo: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete exemplo" do
    setup [:create_exemplo]

    test "deletes chosen exemplo", %{conn: conn, exemplo: exemplo} do
      conn = delete(conn, ~p"/api/exemplos/#{exemplo}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/exemplos/#{exemplo}")
      end
    end
  end

  defp create_exemplo(_) do
    exemplo = exemplo_fixture()
    %{exemplo: exemplo}
  end
end
