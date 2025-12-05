defmodule Aoc.Day3Test do
  use ExUnit.Case

  test "test" do
    assert Aoc.Day3.solve("987654321111111") == 98
    assert Aoc.Day3.solve("811111111111119") == 89
    assert Aoc.Day3.solve("234234234234278") == 78
    assert Aoc.Day3.solve("818181911112111") == 92
  end
end
