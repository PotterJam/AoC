defmodule Aoc.Day7 do
  def solve_pt1(input) do
    [start | rest] =
      input
      |> Stream.map(&String.trim/1)
      |> Stream.map(&String.graphemes/1)
      |> Enum.to_list()

    start_index = start |> Enum.find_index(&(&1 == "S"))

    splitter(rest, MapSet.new([start_index]))
  end

  defp splitter([], _), do: 0

  defp splitter([next | rest], indices) do
    splits =
      next
      |> Enum.with_index()
      |> Enum.reduce(MapSet.new(), fn
        {"^", i}, acc -> MapSet.put(acc, i)
        {_, _}, acc -> acc
      end)

    matching = MapSet.intersection(indices, splits)
    non_matching = MapSet.difference(indices, splits)

    split_indices =
      matching
      |> Enum.flat_map(fn i -> [i - 1, i + 1] end)
      |> MapSet.new()

    new_indices = MapSet.union(non_matching, split_indices)

    MapSet.size(matching) + splitter(rest, new_indices)
  end

  def solve_pt2(_input) do
  end
end
