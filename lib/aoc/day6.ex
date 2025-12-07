defmodule Aoc.Day6 do
  alias List.Chars

  def solve_pt1(input) do
    parsed =
      input
      |> Stream.map(&String.trim/1)
      |> Stream.take_while(&(&1 != ""))
      |> Enum.map(&String.split/1)

    {operations, str_numbers} = List.pop_at(parsed, -1)
    numbers = Enum.map(str_numbers, fn nums -> Enum.map(nums, &String.to_integer/1) end)

    transposed = Enum.zip_with(numbers, &Function.identity/1)

    Enum.zip(operations, transposed)
    |> Enum.sum_by(fn
      {"+", nums} -> Enum.sum(nums)
      {"*", nums} -> Enum.product(nums)
    end)
  end

  def solve_pt2(input) do
    parsed =
      input
      |> Stream.take_while(&(&1 != ""))
      |> Stream.map(&String.graphemes/1)

    Enum.zip_with(parsed, &Function.identity/1)
    |> Stream.chunk_every(3, 4)
    |> Stream.map(fn col ->
      op = Enum.map(col, &Enum.at(&1, -1)) |> Enum.join() |> String.trim()
      {op, col}
    end)
    |> Stream.filter(fn {op, _} -> op in ["+", "*"] end)
    |> Stream.map(fn {op, col} ->
      clean_cols = col

      for n <- col, m <- n do
        case(Integer.parse(m)) do
          {int, ""} -> int
          _ -> nil
        end
      end
      |> Enum.chunk_every(4)
      |> Enum.map(fn col -> Enum.filter(col, &(&1 != nil)) end)
      |> Enum.map(&Integer.undigits/1)
      # need a reverse somewhere?
      |> then(fn nums ->
        case op do
          "+" -> Enum.sum(nums)
          "*" -> Enum.product(nums)
        end
      end)
    end)
    |> Enum.sum()
    |> IO.inspect()
  end
end
