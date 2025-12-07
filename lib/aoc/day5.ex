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

    sorted = ranges |> Enum.sort_by(&elem(&1, 0))

    sorted
    |> combine_ranges()
    |> Enum.sum_by(fn {from, to} -> to - from + 1 end)
  end

  defp combine_ranges([]), do: []

  defp combine_ranges([{_, to} = curr | rest]) do
    overlapping_ranges =
      rest
      |> Enum.take_while(fn {next_from, _} ->
        next_from <= to
      end)

    merged_ranges =
      overlapping_ranges
      |> Enum.filter(fn {_, next_to} -> next_to > to end)
      |> Enum.map(fn
        {_, next_to} -> {to + 1, next_to}
      end)

    rest_without_overlap = rest |> Enum.drop(Enum.count(overlapping_ranges))
    new_rest = Enum.concat(merged_ranges, rest_without_overlap)

    [curr | combine_ranges(new_rest)]
  end
end
