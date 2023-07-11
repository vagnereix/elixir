defmodule BReportsGeneratorTest do
  use ExUnit.Case

  describe "build/1" do
    test "build report" do
      response = BReportsGenerator.build("report_test")

      expected_response = %{
        "foods" => %{
          "açaí" => 1,
          "churrasco" => 2,
          "esfirra" => 3,
          "hambúrguer" => 2,
          "pastel" => 0,
          "pizza" => 2,
          "prato_feito" => 0,
          "sushi" => 0
        },
        "users" => %{
          "1" => 48,
          "10" => 36,
          "11" => 0,
          "12" => 0,
          "13" => 0,
          "14" => 0,
          "15" => 0,
          "16" => 0,
          "17" => 0,
          "18" => 0,
          "19" => 0,
          "2" => 45,
          "20" => 0,
          "21" => 0,
          "22" => 0,
          "23" => 0,
          "24" => 0,
          "25" => 0,
          "26" => 0,
          "27" => 0,
          "28" => 0,
          "29" => 0,
          "3" => 31,
          "30" => 0,
          "4" => 42,
          "5" => 49,
          "6" => 18,
          "7" => 27,
          "8" => 25,
          "9" => 24
        }
      }

      assert response == expected_response
    end
  end

  describe "get_higher_cost/2" do
    test "when users option, returns the user who most spend" do
      file_name = "report_test"

      response =
        file_name
        |> BReportsGenerator.build()
        |> BReportsGenerator.get_higher_cost("users")

      expected_response = {:ok, {"5", 49}}

      assert response == expected_response
    end

    test "when foods option, returns the foods who was most asked" do
      file_name = "report_test"

      response =
        file_name
        |> BReportsGenerator.build()
        |> BReportsGenerator.get_higher_cost("foods")

      expected_response = {:ok, {"esfirra", 3}}

      assert response == expected_response
    end

    test "when invalid option, returns :error" do
      file_name = "report_test"

      response =
        file_name
        |> BReportsGenerator.build()
        |> BReportsGenerator.get_higher_cost("invalid_option")

      expected_response = {:error, "Invalid option"}

      assert response == expected_response
    end
  end

  describe "build_from_files/1" do
    test "when a list was provided, build report" do
      file_names = ["report_1", "report_2"]

      response = BReportsGenerator.build_from_files(file_names)

      expected_response =
        {:ok,
         %{
           "foods" => %{
             "açaí" => 25238,
             "churrasco" => 25053,
             "esfirra" => 24854,
             "hambúrguer" => 25113,
             "pastel" => 24982,
             "pizza" => 24888,
             "prato_feito" => 24957,
             "sushi" => 24915
           },
           "users" => %{
             "1" => 184_323,
             "10" => 176_567,
             "11" => 179_044,
             "12" => 185_851,
             "13" => 186_998,
             "14" => 184_853,
             "15" => 186_518,
             "16" => 182_296,
             "17" => 181_631,
             "18" => 183_243,
             "19" => 184_162,
             "2" => 181_874,
             "20" => 181_689,
             "21" => 182_222,
             "22" => 185_920,
             "23" => 184_014,
             "24" => 182_235,
             "25" => 185_008,
             "26" => 180_918,
             "27" => 183_869,
             "28" => 183_506,
             "29" => 181_974,
             "3" => 181_668,
             "30" => 184_827,
             "4" => 185_312,
             "5" => 182_675,
             "6" => 182_294,
             "7" => 183_114,
             "8" => 182_664,
             "9" => 183_312
           }
         }}

      assert response == expected_response
    end

    test "when a list is not provided, returns error" do
      file_names = ""

      response = BReportsGenerator.build_from_files(file_names)

      expected_response = {:error, "Please provide a list of file names"}

      assert response == expected_response
    end
  end
end
