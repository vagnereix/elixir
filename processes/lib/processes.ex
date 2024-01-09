defmodule Processes do
  def query(n) do
    1..n
    |> Enum.map(&spawn(fn -> execute(&1) end))
  end

  defp execute(q) do
    :timer.sleep(2000)
    IO.puts("Query #{q} executed")
  end

  def receive_calc() do
    receive do
      {:mult, first_value, second_value} -> IO.puts(first_value * second_value)
      {:div, first_value, second_value} -> IO.puts(first_value / second_value)
      {:sum, first_value, second_value} -> IO.puts(first_value + second_value)
      {:sub, first_value, second_value} -> IO.puts(first_value - second_value)
    end
  end

  # Maintain the state of the process, just like an Agent
  def insert_info_into_state(actual_state) do
    receive do
      {:insert, value} ->
        new_person = %{name: value}
        actual_state = actual_state ++ [new_person]

        IO.inspect(actual_state, label: "Actual state")
        insert_info_into_state(actual_state)
    end
  end
end
