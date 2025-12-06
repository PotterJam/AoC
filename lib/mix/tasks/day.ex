defmodule Mix.Tasks.Day do
  use Mix.Task

  def run(args) do
    case parse_args(args) do
      {:ok, day, part} ->
        input_file = "day-#{day}-input.txt"
        module = get_module(day, part)

        if Code.ensure_loaded?(module) do
          File.stream!(input_file) |> module.solve() |> IO.inspect()
        else
          IO.puts("Module #{inspect(module)} not found")
        end

      :error ->
        IO.puts("Usage: mix day <number> [pt2]")
        IO.puts("Example: mix day 1")
        IO.puts("         mix day 3 pt2")
    end
  end

  defp parse_args([day_str | rest]) do
    case Integer.parse(day_str) do
      {day, ""} ->
        part = if "pt2" in rest, do: 2, else: 1
        {:ok, day, part}

      _ ->
        :error
    end
  end

  defp parse_args(_), do: :error

  defp get_module(day, 1), do: Module.concat(Aoc, "Day#{day}")
  defp get_module(day, 2), do: Module.concat(Aoc, "Day#{day}Pt2")
end
