defmodule CExlivery.Orders.CreateOrUpdate do
  alias CExlivery.Orders.Agent, as: OrderAgent
  alias CExlivery.Orders.Item
  alias CExlivery.Orders.Order
  alias CExlivery.Users.Agent, as: UserAgent

  def call(%{user_cpf: cpf, items: items}) do
    with {:ok, user} <- UserAgent.get(cpf),
         {:ok, items} <- build_items(items),
         {:ok, order} <- Order.build(user, items) do
      OrderAgent.save(order)
    else
      error -> error
    end
  end

  defp build_items(items) do
    Enum.map(items, &build_item/1)
    |> handle_build()
  end

  defp build_item(%{
         description: description,
         category: category,
         unity_price: unity_price,
         quantity: quantity
       }) do
    case Item.build(description, category, unity_price, quantity) do
      {:ok, item} -> item
      {:error, _} = error -> error
    end
  end

  defp handle_build(items) do
    if Enum.all?(items, &is_struct/1), do: {:ok, items}, else: {:error, "Invalid items"}
  end
end
