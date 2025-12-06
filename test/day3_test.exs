defmodule Aoc.Day3Test do
  use ExUnit.Case

  test "day_3_tests" do
    assert Aoc.Day3.solve(["987654321111111"]) == 98
    assert Aoc.Day3.solve(["811111111111119"]) == 89
    assert Aoc.Day3.solve(["234234234234278"]) == 78
    assert Aoc.Day3.solve(["818181911112111"]) == 92
  end

  test "day_3_pt2_tests" do
    assert Aoc.Day3Pt2.solve(["234234234234278"]) == 434_234_234_278
  end
end
