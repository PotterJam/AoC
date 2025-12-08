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

  def solve_pt2(input) do
    [start | rest] =
      input
      |> Stream.map(&String.trim/1)
      |> Stream.map(&String.graphemes/1)
      |> Enum.to_list()

    start_index = start |> Enum.find_index(&(&1 == "S"))

    find_paths(rest, %{start_index => 1})
  end

  defp find_paths([], path_counts) do
    path_counts |> Map.values() |> Enum.sum()
  end

  defp find_paths([next | rest], path_counts) do
    splits =
      next
      |> Enum.with_index()
      |> Enum.reduce(MapSet.new(), fn
        {"^", i}, acc -> MapSet.put(acc, i)
        {_, _}, acc -> acc
      end)

    new_path_counts =
      path_counts
      |> Enum.flat_map(fn {idx, count} ->
        if MapSet.member?(splits, idx) do
          [{idx - 1, count}, {idx + 1, count}]
        else
          [{idx, count}]
        end
      end)

    deduped_counts =
      new_path_counts
      |> Enum.group_by(fn {idx, _} -> idx end, fn {_, count} -> count end)
      |> Map.new(fn {idx, counts} -> {idx, Enum.sum(counts)} end)

    find_paths(rest, deduped_counts)
  end
end
