defmodule Aoc.Day5 do
  def solve_pt1(input) do
    {ranges, ids} = parse(input)

    range_fns =
      ranges
      |> Enum.map(fn {from, to} ->
        fn id -> id >= from and id <= to end
      end)

    ids
    |> Enum.count(fn id ->
      Enum.any?(range_fns, & &1.(id))
    end)
  end

  defp parse(input) do
    lines = input |> Stream.map(&String.trim/1)

    ranges =
      lines
      |> Stream.take_while(&(&1 != ""))
      |> Enum.map(fn range_str ->
        [from, to] = String.split(range_str, "-")
        {String.to_integer(from), String.to_integer(to)}
      end)

    ids =
      lines
      |> Stream.drop_while(&(&1 != ""))
      |> Stream.drop(1)
      |> Stream.take_while(&(&1 != ""))
      |> Enum.map(&String.to_integer/1)

    {ranges, ids}
  end

  def solve_pt2(_input) do
  end
end
