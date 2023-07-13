defmodule CExlivery.Orders.ReportTest do
  use ExUnit.Case

  import CExlivery.Factory

  alias CExlivery.Orders.Agent, as: OrderAgent
  alias CExlivery.Orders.Report

  describe "create/1" do
    setup do
      OrderAgent.start_link(%{})
      :ok
    end

    test "creates a report file" do
      order = build(:order)
      OrderAgent.save(order)

      Report.create("test_report")

      assert File.exists?("reports/test_report.csv")
    end

    test "file has a correct content report" do
      :order
      |> build()
      |> OrderAgent.save()

      :order
      |> build()
      |> OrderAgent.save()

      Report.create("test_report")

      expected_response =
        "12345678900,Pizza,pizza,1,10.23,Temaki,japonesa,2,10.00,30.23\n" <>
          "12345678900,Pizza,pizza,1,10.23,Temaki,japonesa,2,10.00,30.23\n"

      assert expected_response == File.read!("reports/test_report.csv")
    end
  end
end
