defmodule Aoc.Day4 do
  def solve_pt1(input) do
    parsed =
      input
      |> Stream.map(&String.trim/1)
      |> Stream.map(&String.graphemes/1)

    map =
      parsed
      |> Enum.with_index()
      |> Enum.reduce(%{}, &neighbour_adder/2)

    parsed
    |> Enum.with_index()
    |> Enum.sum_by(fn {line, y} ->
      line
      |> Enum.with_index()
      |> Enum.count(fn {ch, x} ->
        ch == "@" and Map.get(map, {x, y}, 0) < 4
      end)
    end)
  end

  defp neighbour_adder({line, y}, acc) do
    line
    |> Enum.with_index()
    |> Enum.reduce(acc, fn {ch, x}, acc ->
      if ch == "@" do
        neighbour_indices(x, y)
        |> Enum.reduce(acc, fn {neigh_x, neigh_y}, acc ->
          Map.update(acc, {neigh_x, neigh_y}, 1, &(&1 + 1))
        end)
      else
        acc
      end
    end)
  end

  defp neighbour_indices(x, y) do
    (x - 1)..(x + 1)
    |> Enum.flat_map(fn i ->
      (y - 1)..(y + 1)
      |> Enum.map(&{i, &1})
      |> Enum.filter(&(&1 != {x, y}))
    end)
  end
end
