defmodule CExliveryTest do
  use ExUnit.Case

  import CExlivery.Factory

  alias CExlivery.Users.Agent, as: UserAgent

  describe "create_or_update_user/1" do
    setup do
      CExlivery.start_agents()
      :ok
    end

    test "create user" do
      assert {:ok, _user} = CExlivery.create_or_update_user(build(:user))
    end
  end

  describe "create_or_update_order/1" do
    setup do
      CExlivery.start_agents()
      :ok
    end

    test "create order" do
      user = build(:user)
      item = build(:item)

      UserAgent.save(user)

      assert {:ok, _uuid} = CExlivery.create_or_update_order(%{user_cpf: user.cpf, items: [item]})
    end
  end
end
