defmodule Aoc.Day4 do
  def solve_pt1(input) do
    parsed =
      input
      |> Stream.map(&String.trim/1)
      |> Stream.map(&String.graphemes/1)

    set =
      parsed
      |> Enum.with_index()
      |> Enum.reduce(MapSet.new(), fn {line, y}, acc ->
        line
        |> Enum.with_index()
        |> Enum.reduce(acc, fn
          {"@", x}, acc -> MapSet.put(acc, {x, y})
          _, acc -> acc
        end)
      end)

    free(set) |> length()
  end

  def solve_pt2(input) do
    parsed =
      input
      |> Stream.map(&String.trim/1)
      |> Stream.map(&String.graphemes/1)

    set =
      parsed
      |> Enum.with_index()
      |> Enum.reduce(MapSet.new(), fn {line, y}, acc ->
        line
        |> Enum.with_index()
        |> Enum.reduce(acc, fn
          {"@", x}, acc -> MapSet.put(acc, {x, y})
          _, acc -> acc
        end)
      end)

    recursively_free(set)
  end

  defp free(set) do
    set
    |> Enum.filter(fn coords ->
      neighbour_indices(coords) |> Enum.count(&MapSet.member?(set, &1)) < 4
    end)
  end

  defp recursively_free(set) do
    now_free = free(set)

    if Enum.empty?(now_free) do
      0
    else
      new_set = MapSet.difference(set, MapSet.new(now_free))
      Enum.count(now_free) + recursively_free(new_set)
    end
  end

  defp neighbour_indices({x, y}) do
    (x - 1)..(x + 1)
    |> Enum.flat_map(fn i ->
      (y - 1)..(y + 1)
      |> Enum.map(&{i, &1})
      |> Enum.filter(&(&1 != {x, y}))
    end)
  end
end
