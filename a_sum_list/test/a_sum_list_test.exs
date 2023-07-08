defmodule ASumListTest do
  use ExUnit.Case
  doctest ASumList

  # Sempre testamos as funções públicas
  # Sempre especificamos a aridade da função que estamos testando
  describe "call/1" do
    test "sum a empty list" do
      assert ASumList.call([]) == 0
    end

    test "sum a filled list" do
      assert ASumList.call([1,2]) == 3
    end
  end
end
