defmodule CExlivery.Orders.OrderTest do
  use ExUnit.Case

  alias CExlivery.Orders.Order

  import CExlivery.Factory

  describe "build/2" do
    test "when all params are valid, returns order" do
      user = build(:user)

      items = [
        build(:item),
        build(:item,
          description: "Temaki",
          category: :japonesa,
          unity_price: "10.00",
          quantity: 2
        )
      ]

      response = Order.build(user, items)
      expected_response = {:ok, build(:order)}
      assert response == expected_response
    end

    test "when is a invalid unity price, returns error" do
      response = Order.build("invalid_user", "invalid_items")
      expected_response = {:error, "Invalid parameters"}
      assert response == expected_response
    end
  end
end
