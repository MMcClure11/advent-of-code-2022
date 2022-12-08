defmodule Mix.Tasks.Aoc.Gen.Solution do
  @moduledoc """
  Generates an empty Advent of Code solution.
      $ mix aoc.gen.solution 06_tuning_trouble
  The above would generate:
    * `lib/advent_of_code/06_tuning_trouble.ex`
    * `test/advent_of_code/06_tuning_trouble_test.exs`
    * `test/advent_of_code/06_tuning_trouble.txt`
    * `priv/input/06_tuning_trouble_test.txt`

  """
  use Mix.Task

  def run([name]) do
    name
    |> write_lib_file()
    |> write_test_folder()
    |> write_test_file()
    |> write_input_file()
    |> write_test_input_file()
  end

  defp write_lib_file(name) do
    contents = lib_contents(name)
    File.write!("lib/advent_of_code/#{name}.ex", contents)
    name
  end

  defp lib_contents(name) do
    """
    defmodule AdventOfCode.#{module_name(name)} do
      @moduledoc false
      import AdventOfCode
      def part_one, do: "#{name}.txt" |> read_input() |> part_one()
      def part_one(input), do: dbg(input)
      def part_two, do: "#{name}.txt" |> read_input() |> part_two()
      def part_two(input), do: dbg(input)
    end
    """
  end

  defp write_test_folder(name) do
    File.mkdir!("test/advent_of_code/#{name}")
    name
  end

  defp write_test_file(name) do
    contents = test_contents(name)
    File.write!("test/advent_of_code/#{name}/#{name}_test.exs", contents)
    name
  end

  defp test_contents(name) do
    module_name = module_name(name)

    """
    defmodule AdventOfCode.#{module_name}Test do
      use ExUnit.Case
      import AdventOfCode.#{module_name}
      @input \"\"\"
      \"\"\"
      test "part_one/1", do: assert(part_one(@input))
      test "part_two/1", do: assert(part_two(@input))
    end
    """
  end

  defp write_input_file(name) do
    File.write!("priv/input/#{name}.txt", "")
    name
  end

  defp write_test_input_file(name) do
    File.write!("test/advent_of_code/#{name}/#{name}.txt", "")
    name
  end

  defp module_name(<<_::binary-size(2)>> <> name), do: Macro.camelize(name)
end
