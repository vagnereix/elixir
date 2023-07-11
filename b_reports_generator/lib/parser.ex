defmodule BReportsGenerator.Parser do
  def parse_file(filename) do
    "reports/#{filename}.csv"
    |> file_exists?()
    |> File.stream!()
    |> Stream.map(&parse_line/1)
  end

  defp file_exists?(file_path) do
    File.exists?(file_path)
    |> case do
      true -> file_path
      false -> raise "File not found"
    end
  end

  defp parse_line(line) do
    line
    |> String.trim()
    |> String.split(",")
    |> List.update_at(2, &String.to_integer/1)
  end
end
