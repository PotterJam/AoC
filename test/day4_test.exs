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

    assert Aoc.Day4.solve_pt1(input) == 3
  end

  test "day_4_part_2" do
    input = [
      "@....",
      "...@.",
      "..@@.",
      "..@@.",
      "....."
    ]

    assert Aoc.Day4Pt2.solve_pt1(input) == 6
  end
end
