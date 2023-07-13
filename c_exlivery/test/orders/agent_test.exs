defmodule CExlivery.Orders.AgentTest do
  use ExUnit.Case

  alias CExlivery.Orders.Agent, as: OrderAgent

  import CExlivery.Factory

  describe "call/1" do
    setup do
      OrderAgent.start_link(%{})
      :ok
    end

    test "creates an order" do
      order = build(:order)
      assert {:ok, _uuid} = OrderAgent.save(order)
    end

    test "returns an order when she exists" do
      order = build(:order)
      {:ok, uuid} = OrderAgent.save(order)

      assert OrderAgent.get(uuid) == {:ok, order}
    end

    test "returns an error when order is not found" do
      assert OrderAgent.get("invalid-uuid") == {:error, "Order not found"}
    end
  end
end
