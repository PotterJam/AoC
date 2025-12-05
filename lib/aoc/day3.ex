defmodule Aoc.Day3 do
  # 81911 would return 91.
  # We can go left to right with pointers and when we see a higher number
  # on the rhs we can just count that as the highest value and reset the left pointer.
  def solve(input) do
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

  defp to_number_list(battery_bank) do
    battery_bank
    |> String.trim()
    |> String.graphemes()
    |> Enum.map(&String.to_integer/1)
  end
end
