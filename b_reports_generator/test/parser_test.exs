defmodule BReportsGenerator.ParserTest do
  use ExUnit.Case

  alias BReportsGenerator.Parser

  describe "parse_file/1" do
    test "when file exists" do
      file_name = "report_test"

      response =
        file_name
        |> Parser.parse_file()
        |> Enum.map(& &1)

      expected_response = [
        ["1", "pizza", 48],
        ["2", "açaí", 45],
        ["3", "hambúrguer", 31],
        ["4", "esfirra", 42],
        ["5", "hambúrguer", 49],
        ["6", "esfirra", 18],
        ["7", "pizza", 27],
        ["8", "esfirra", 25],
        ["9", "churrasco", 24],
        ["10", "churrasco", 36]
      ]

      assert response == expected_response
    end

    test "when file does not exist" do
      file_name = "report_test_2"

      assert_raise RuntimeError, "File not found", fn ->
        file_name
        |> Parser.parse_file()
      end
    end
  end
end
