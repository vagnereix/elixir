defmodule CExlivery.Users.AgentTest do
  use ExUnit.Case

  alias CExlivery.Users.Agent, as: UserAgent

  import CExlivery.Factory

  describe "save/1" do
    test "saves a user" do
      user = build(:user)
      UserAgent.start_link(%{})
      assert UserAgent.save(user) == :ok
    end
  end

  describe "get/1" do
    setup do
      UserAgent.start_link(%{})
      :ok
    end

    test "returns a user" do
      user = build(:user)
      UserAgent.save(user)

      assert UserAgent.get(user.cpf) == {:ok, user}
    end

    test "returns an error when user is not found" do
      assert UserAgent.get("123") == {:error, "User not found"}
    end
  end
end
