defmodule CExlivery.Orders.ItemTest do
  use ExUnit.Case

  alias CExlivery.Orders.Item

  import CExlivery.Factory

  describe "build/4" do
    test "when all params are valid, returns item" do
      response = Item.build("Pizza", :pizza, 10.23, 1)
      expected_response = {:ok, build(:item)}
      assert response == expected_response
    end

    test "when is a invalid category, returns error" do
      response = Item.build("Pizza", :invalid_category, 10.23, 1)
      expected_response = {:error, "Invalid parameters"}
      assert response == expected_response
    end

    test "when is a invalid price, returns error" do
      response = Item.build("Pizza", :pizza, "invalid_price", 1)
      expected_response = {:error, "Invalid unity price"}
      assert response == expected_response
    end

    test "when is a invalid quantity, returns error" do
      response = Item.build("Pizza", :pizza, "10.23", 0)
      expected_response = {:error, "Invalid parameters"}
      assert response == expected_response
    end
  end
end
