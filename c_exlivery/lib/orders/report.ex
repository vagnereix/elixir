defmodule CExlivery.Orders.Report do
  alias CExlivery.Orders.Agent, as: OrderAgent
  alias CExlivery.Orders.Item
  alias CExlivery.Orders.Order

  def create(filename \\ "report") do
    orders = build_order_list()
    File.write("reports/#{filename}.csv", orders)
  end

  def build_order_list do
    OrderAgent.get_all()
    |> Map.values()
    |> Enum.map(&order_to_string/1)
  end

  defp order_to_string(%Order{user_cpf: cpf, items: items, total_price: amount}) do
    items_string = Enum.map(items, &item_to_string/1)
    "#{cpf}#{items_string},#{amount}\n"
  end

  defp item_to_string(%Item{
         category: category,
         quantity: quantity,
         description: description,
         unity_price: price
       }) do
    ",#{description},#{category},#{quantity},#{price}"
  end
end
