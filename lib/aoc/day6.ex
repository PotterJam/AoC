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
      |> Stream.map(&String.trim_trailing/1)
      |> Enum.map(&String.graphemes/1)

    max_len = parsed |> Enum.max_by(&length/1) |> length()

    pad_enum = fn enum ->
      enum ++ (Stream.cycle([" "]) |> Enum.take(max_len - length(enum)))
    end

    padded = Enum.map(parsed, pad_enum)

    cols_with_ops =
      Enum.zip_with(padded, &Function.identity/1)
      |> Enum.chunk_by(fn row -> Enum.all?(row, &(&1 == " ")) end)
      |> Enum.reject(fn chunk ->
        chunk |> hd() |> Enum.all?(&(&1 == " "))
      end)
      |> Stream.map(fn col ->
        op = Enum.map(col, &Enum.at(&1, -1)) |> Enum.join() |> String.trim()
        {op, col}
      end)
      |> Stream.filter(fn {op, _} -> op in ["+", "*"] end)

    cols_with_ops
    |> Stream.map(fn {op, col} ->
      chunk_size = col |> hd() |> length()

      for n <- col, m <- n do
        case(Integer.parse(m)) do
          {int, ""} -> int
          _ -> nil
        end
      end
      |> Enum.chunk_every(chunk_size)
      |> Enum.map(fn col -> Enum.filter(col, &(&1 != nil)) end)
      |> Enum.map(&Integer.undigits/1)
      |> then(fn nums ->
        case op do
          "+" -> Enum.sum(nums)
          "*" -> Enum.product(nums)
        end
      end)
    end)
    |> Enum.sum()
  end
end
