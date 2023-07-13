defmodule CExlivery do
  alias CExlivery.Orders.Agent, as: OrderAgent
  alias CExlivery.Orders.CreateOrUpdate, as: CreateOrUpdateOrder
  alias CExlivery.Users.Agent, as: UserAgent
  alias CExlivery.Users.CreateOrUpdate, as: CreateOrUpdateUser

  def start_agents do
    UserAgent.start_link(%{})
    OrderAgent.start_link(%{})
  end

  defdelegate create_or_update_user(params), to: CreateOrUpdateUser, as: :call
  defdelegate create_or_update_order(params), to: CreateOrUpdateOrder, as: :call
end
