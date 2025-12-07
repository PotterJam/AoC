defmodule Aoc.Day6Test do
  use ExUnit.Case

  test "day_6_part_1" do
    input =
      """
      123 328  51 64
       45 64  387 23
        6 98  215 314
      *   +   *   +
      """
      |> String.split("\n")

    assert Aoc.Day6.solve_pt1(input) == 4_277_556
  end

  test "day_6_part_2" do
  end
end
