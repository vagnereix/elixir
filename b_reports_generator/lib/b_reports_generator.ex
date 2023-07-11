defmodule BReportsGenerator do
  alias BReportsGenerator.Parser

  @available_foods [
    "açaí",
    "churrasco",
    "esfirra",
    "hambúrguer",
    "pastel",
    "pizza",
    "prato_feito",
    "sushi"
  ]

  @options ["foods", "users"]

  def build_from_files(files) when not is_list(files),
    do: {:error, "Please provide a list of file names"}

  def build_from_files(files) do
    {
      :ok,
      files
      |> Task.async_stream(&build/1)
      |> Enum.reduce(generate_initial_report(), fn {_status, report}, acc ->
        merge_reports(acc, report)
      end)
    }
  end

  def build(filename) do
    filename
    |> Parser.parse_file()
    |> Enum.reduce(generate_initial_report(), &put_map(&1, &2))
  end

  def get_higher_cost(report, option) when option in @options do
    {:ok, Enum.max_by(report[option], fn {_, value} -> value end)}
  end

  def get_higher_cost(_, _), do: {:error, "Invalid option"}

  defp generate_initial_report do
    foods = Enum.into(@available_foods, %{}, &{&1, 0})
    users = Enum.into(1..30, %{}, &{Integer.to_string(&1), 0})

    %{"foods" => foods, "users" => users}
  end

  defp put_map([id, food_name, price], %{"foods" => foods, "users" => users} = acc) do
    foods = Map.put(foods, food_name, foods[food_name] + 1)
    users = Map.put(users, id, users[id] + price)

    %{acc | "foods" => foods, "users" => users}
  end

  defp merge_reports(%{"foods" => foods1, "users" => users1}, %{
         "foods" => foods2,
         "users" => users2
       }) do
    %{
      "foods" => Map.merge(foods1, foods2, fn _key, value1, value2 -> value1 + value2 end),
      "users" => Map.merge(users1, users2, fn _key, value1, value2 -> value1 + value2 end)
    }
  end
end
