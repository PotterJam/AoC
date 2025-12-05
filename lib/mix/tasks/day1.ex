defmodule Mix.Tasks.Day1 do
  use Mix.Task

  def run(_) do
    File.stream!("day-1-input.txt") |> Aoc.Day1.solve() |> IO.inspect()
  end
end
