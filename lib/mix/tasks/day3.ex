defmodule Mix.Tasks.Day3 do
  use Mix.Task

  def run(_) do
    File.stream!("day-3-input.txt") |> Aoc.Day3.solve() |> IO.inspect()
  end
end

defmodule Mix.Tasks.Day3Pt2 do
  use Mix.Task

  def run(_) do
    File.stream!("day-3-input.txt") |> Aoc.Day3Pt2.solve() |> IO.inspect()
  end
end
