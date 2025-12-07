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

  def solve_pt2(input) do
    {ranges, _} = parse(input)

    sorted = ranges |> Enum.sort_by(fn {from, _} -> from end)

    sorted
    |> combine_ranges()
    |> Enum.sum_by(fn {from, to} -> to - from + 1 end)
  end

  defp combine_ranges([]), do: []

  defp combine_ranges([{_, to} = curr | rest]) do
    {overlapping, remaining} = Enum.split_while(rest, fn {next_from, _} -> next_from <= to end)

    merged_ranges =
      for {_, next_to} <- overlapping, next_to > to, do: {to + 1, next_to}

    [curr | combine_ranges(merged_ranges ++ remaining)]
  end
end
