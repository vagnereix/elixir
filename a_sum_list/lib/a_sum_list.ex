defmodule ASumList do
  @moduledoc """
  Documentation for `ASumList`.
  """

  @doc """
  ## Examples
    Sum a empty list:
      iex> ASumList.call([])
      0

    Sum a filled list:
      iex> ASumList.call([1,2])
      3
  """

  def call(list), do: sum(list, 0)

  defp sum([], acc), do: acc
  defp sum([head | tale], acc) do
    acc = acc + head
    sum(tale, acc)
  end

  def enum_sum(list), do: Enum.sum(list)
  def enum_max(list), do: Enum.max(list)
  def enum_min(list), do: Enum.min(list)

  def enum_map_anon(list), do: Enum.map(list, fn elem -> elem + 1 end)
  def enum_map_short(list), do: Enum.map(list, &(&1 + 1))

  # Toda função que termina com interrogação retorna um booleano
  def is_someone_bigger_than_one_anon(list), do: Enum.any?(list, fn elem -> elem > 1 end)
  def is_someone_bigger_than_one_short(list), do: Enum.any?(list, &(&1 > 1))
end
