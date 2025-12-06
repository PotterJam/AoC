defmodule Aoc.Day2 do
  def solve_pt1(input) do
    input
    |> String.split(",")
    |> Enum.flat_map(fn range_str ->
      [from, to] = String.split(range_str, "-")
      [from_int, to_int] = [String.to_integer(from), String.to_integer(to)]
      [from_len, to_len] = [String.length(from), String.length(to)]

      from_len..to_len
      |> Enum.flat_map(fn current_len ->
        if current_len < 2,
          do: [],
          else:
            1..div(current_len, 2)
            |> Enum.flat_map(fn block_len ->
              if Integer.mod(current_len, block_len) == 0 do
                repeat_count = div(current_len, block_len)
                min_sequential_block = floor(10 ** (block_len - 1))
                max_sequential_block = floor(10 ** block_len) - 1

                min_sequential_block..max_sequential_block
                |> Enum.map(fn block_to_sequence ->
                  block = Integer.to_string(block_to_sequence)
                  String.duplicate(block, repeat_count) |> String.to_integer()
                end)
              else
                []
              end
            end)
      end)
      |> Enum.uniq()
      |> Enum.filter(&(&1 >= from_int && &1 <= to_int))
    end)
    |> Enum.sum()
    |> IO.inspect()

    # 10^0..10^1-1, 10^1..10^2-1... etc
  end
end
