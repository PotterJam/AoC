defmodule Mix.Tasks.Create do
  use Mix.Task

  def run(["day", day_str]) do
    case Integer.parse(day_str) do
      {day, ""} ->
        create_day(day)

      _ ->
        IO.puts("Usage: mix create day <number>")
    end
  end

  def run(_) do
    IO.puts("Usage: mix create day <number>")
  end

  defp create_day(day) do
    module_file = "lib/aoc/day#{day}.ex"
    test_file = "test/day#{day}_test.exs"
    input_file = "day-#{day}-input.txt"

    module_content = """
    defmodule Aoc.Day#{day} do
      def solve_pt1(input) do
      end

      def solve_pt2(input) do
      end
    end
    """

    test_content = """
    defmodule Aoc.Day#{day}Test do
      use ExUnit.Case

      test "day_#{day}_part_1" do
      end

      test "day_#{day}_part_2" do
      end
    end
    """

    write_if_missing(module_file, module_content)
    write_if_missing(test_file, test_content)
    write_if_missing(input_file, "")
  end

  defp write_if_missing(path, content) do
    if File.exists?(path) do
      IO.puts("#{path} already exists, skipping")
    else
      File.write!(path, content)
      IO.puts("Created #{path}")
    end
  end
end
