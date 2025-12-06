defmodule Aoc.Day3 do
  def solve_pt1(input) do
    input
    |> Stream.map(fn bank -> bank |> to_number_list() |> largest_joltage(0, 0) end)
    |> Enum.sum()
  end

  defp largest_joltage([], left, right), do: left * 10 + right

  defp largest_joltage(numbers, left, right) do
    case numbers do
      [last] ->
        largest_joltage([], left, max(last, right))

      [n | rest] when n > left ->
        largest_joltage(rest, n, hd(rest))

      [n | rest] ->
        largest_joltage(rest, left, max(n, right))
    end
  end

  def solve_pt2(input) do
    voltages = 12

    input
    |> Stream.map(fn bank -> bank |> to_number_list() |> find_max({0, []}, voltages) end)
    |> Enum.sum()
  end

  defp find_max(_, _, 0), do: 0

  defp find_max(numbers, {curr_max, from_curr_max}, buffer_needed)
       when length(numbers) < buffer_needed do
    unit = Integer.pow(10, buffer_needed - 1)
    curr_max * unit + find_max(from_curr_max, {0, []}, buffer_needed - 1)
  end

  defp find_max([n | rest], {curr_max, _} = acc, buffer_needed) do
    if n > curr_max,
      do: find_max(rest, {n, rest}, buffer_needed),
      else: find_max(rest, acc, buffer_needed)
  end

  defp to_number_list(battery_bank) do
    battery_bank
    |> String.trim()
    |> String.graphemes()
    |> Enum.map(&String.to_integer/1)
  end
end
