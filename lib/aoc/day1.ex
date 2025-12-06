defmodule Aoc.Day1 do
  def solve_pt1(lines) do
    lines
    |> Stream.map(&parse_line/1)
    |> Stream.scan({50, 0}, &get_crossing_counts/2)
    |> Enum.sum_by(fn {_, c} -> c end)
  end

  def get_crossing_counts(rotation, {pos, _}) do
    sum = pos + rotation

    crossings =
      if rotation >= 0,
        do: div(sum, 100),
        else: ceil(pos / 100) - ceil(sum / 100)

    {Integer.mod(sum, 100), crossings}
  end

  def parse_line(line) do
    case String.split_at(String.trim(line), 1) do
      {"L", num_str} -> -String.to_integer(num_str)
      {"R", num_str} -> String.to_integer(num_str)
    end
  end
end
