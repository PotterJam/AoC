defmodule Aoc.Day1Test do
  use ExUnit.Case

  test "no crossing right" do
    assert Aoc.Day1.get_crossing_counts(10, {50, 0}) == {60, 0}
  end

  test "crossing right once" do
    assert Aoc.Day1.get_crossing_counts(60, {50, 0}) == {10, 1}
  end

  test "no crossing left" do
    assert Aoc.Day1.get_crossing_counts(-10, {50, 0}) == {40, 0}
  end

  test "crossing left once" do
    assert Aoc.Day1.get_crossing_counts(-60, {50, 0}) == {90, 1}
  end
end
