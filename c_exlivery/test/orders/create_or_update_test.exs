defmodule CExlivery.Orders.CreateOrUpdateTest do
  use ExUnit.Case

  alias CExlivery.Orders.CreateOrUpdate
  alias CExlivery.Users.Agent, as: UserAgent

  import CExlivery.Factory

  describe "call/1" do
    setup do
      CExlivery.start_agents()

      user = build(:user)

      item =
        build(:item,
          description: "Temaki",
          category: :japonesa,
          unity_price: "10.00",
          quantity: 2
        )

      {:ok, user: user, item: item}
    end

    test "creates an order", %{user: user, item: item} do
      items = [item]

      UserAgent.save(user)

      assert {:ok, _uuid} = CreateOrUpdate.call(%{user_cpf: user.cpf, items: items})
    end

    test "when user is not found, returns an error", %{item: item} do
      items = [item]

      assert CreateOrUpdate.call(%{user_cpf: "invalid-cpf", items: items}) ==
               {:error, "User not found"}
    end

    test "when some item has a invalid quantity, returns an error", %{user: user} do
      items = [build(:item, quantity: 0)]

      UserAgent.save(user)

      assert CreateOrUpdate.call(%{user_cpf: user.cpf, items: items}) ==
               {:error, "Invalid items"}
    end

    test "when some item has a invalid unity price, returns an error", %{user: user} do
      items = [build(:item, unity_price: "invalid-price")]

      UserAgent.save(user)

      assert CreateOrUpdate.call(%{user_cpf: user.cpf, items: items}) ==
               {:error, "Invalid items"}
    end

    test "when some item has a invalid category, returns an error", %{user: user} do
      items = [build(:item, category: :invalid_category)]

      UserAgent.save(user)

      assert CreateOrUpdate.call(%{user_cpf: user.cpf, items: items}) ==
               {:error, "Invalid items"}
    end
  end
end
