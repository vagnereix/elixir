defmodule CExlivery.Orders.Agent do
  alias CExlivery.Orders.Order

  use Agent

  def start_link(_initial_state) do
    Agent.start_link(fn -> %{} end, name: __MODULE__)
  end

  def save(%Order{} = order) do
    order_id = UUID.uuid4()
    Agent.update(__MODULE__, fn state -> Map.put(state, order_id, order) end)
    {:ok, order_id}
  end

  def get(uuid), do: Agent.get(__MODULE__, &get_order(&1, uuid))

  def get_all(), do: Agent.get(__MODULE__, & &1)

  defp get_order(state, uuid) do
    case Map.get(state, uuid) do
      nil -> {:error, "Order not found"}
      order -> {:ok, order}
    end
  end
end
