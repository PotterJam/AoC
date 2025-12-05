defmodule Mix.Tasks.Day2 do
  use Mix.Task

  def run(_) do
    File.stream!("day-2-input.txt") |> Aoc.Day2.solve() |> IO.inspect()
  end
end
