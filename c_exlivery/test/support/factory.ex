defmodule CExlivery.Factory do
  use ExMachina

  alias CExlivery.Orders.{Item, Order}
  alias CExlivery.Users.User

  def user_factory do
    %User{
      name: "Vagner",
      email: "vagnereix.dev@gmail.com",
      cpf: "12345678900",
      age: 24,
      address: "Altiplano"
    }
  end

  def item_factory do
    %Item{
      description: "Pizza",
      category: :pizza,
      unity_price: Decimal.new("10.23"),
      quantity: 1
    }
  end

  def order_factory do
    %Order{
      user_cpf: "12345678900",
      delivery_address: "Altiplano",
      items: [
        %CExlivery.Orders.Item{
          description: "Pizza",
          category: :pizza,
          unity_price: Decimal.new("10.23"),
          quantity: 1
        },
        %CExlivery.Orders.Item{
          description: "Temaki",
          category: :japonesa,
          unity_price: Decimal.new("10.00"),
          quantity: 2
        }
      ],
      total_price: Decimal.new("30.23")
    }
  end
end
