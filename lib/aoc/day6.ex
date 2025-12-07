defmodule Aoc.Day6 do
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

  def solve_pt2(_input) do
  end
end
