defmodule Aoc.Day3Pt2 do
  # 234234234234278 would return 434234234278.
  # We just need to find every highest number from index 0 to length-n, where n is the length left that we require.
  # Sounds like a job for Dr Recursion.
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
