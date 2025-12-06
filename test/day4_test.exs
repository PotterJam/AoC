defmodule Aoc.Day4Test do
  use ExUnit.Case

  test "day_4" do
    input = [
      "@....",
      ".....",
      "..@@.",
      ".....",
      "....."
    ]

    assert Aoc.Day4.solve(input) == 3
  end
end
