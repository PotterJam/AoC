defmodule Aoc.Day5Test do
  use ExUnit.Case

  test "day_5_part_1" do
    input =
      """
      3-5
      10-14
      16-20
      12-18

      1
      5
      8
      11
      17
      32
      """
      |> String.split("\n")

    assert Aoc.Day5.solve_pt1(input) == 3
  end

  test "day_5_part_2" do
    input =
      """
      3-5
      10-14
      12-18
      16-17
      """
      |> String.split("\n")

    assert Aoc.Day5.solve_pt2(input) == 12
  end
end
