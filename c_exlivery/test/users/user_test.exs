defmodule CExlivery.Users.UserTest do
  use ExUnit.Case

  alias CExlivery.Users.User

  describe "build/5" do
    test "when all params is valid, returns the new user" do
      assert {:ok, %User{}} =
               User.build("Vagner", "vagnereix.dev@gmail.com", "12345678900", 24, "Altiplano")
    end

    test "when user is not older than 18, returns the specific error" do
      assert {:error, "User must be 18 years old or older"} =
               User.build("Vagner", "vag@g.c", "12345678900", 17, "Altiplano")
    end
  end
end
