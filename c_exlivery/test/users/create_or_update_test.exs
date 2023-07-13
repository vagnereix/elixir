defmodule CExlivery.Users.CreateOrUpdateTest do
  use ExUnit.Case

  alias CExlivery.Users.Agent, as: UserAgent
  alias CExlivery.Users.CreateOrUpdate

  import CExlivery.Factory

  describe "call/1" do
    setup do
      UserAgent.start_link(%{})
      :ok
    end

    test "creates a user" do
      user = build(:user)
      assert CreateOrUpdate.call(user) == {:ok, "User created or update successfully"}
    end

    test "returns error when user age is not 18 or old" do
      user = build(:user, %{age: 17})
      assert CreateOrUpdate.call(user) == {:error, "User must be 18 years old or older"}
    end
  end
end
