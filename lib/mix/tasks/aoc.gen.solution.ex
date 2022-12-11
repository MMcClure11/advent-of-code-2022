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

      @doc \"""
      \"""
      @spec part_one(String.t(), []) :: pos_integer()
      def part_one(data, opts \\\\ []) do
        path = Keyword.get(opts, :path, "priv/input/")

        data
        |> parse_data(path)
      end

      defp parse_data(data, path) do
        data
        |> read_input(path: path)
        |> IO.inspect()
      end

      @doc \"""
      \"""
      @spec part_two(String.t(), []) :: pos_integer()
      def part_two(data, opts \\\\ []) do
        path = Keyword.get(opts, :path, "priv/input/")

        data
        |> parse_data(path)
        |> IO.inspect()
      end
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

      alias AdventOfCode.#{module_name}

      describe "part_one/2" do
        test "returns the correct result for example" do
          assert :x ==
                  #{module_name}.part_one("#{name}.txt",
                     path: "test/advent_of_code/#{name}/"
                   )
        end

        test "returns the correct result" do
          assert :y ==
                   #{module_name}.part_one("#{name}.txt")
        end
      end

      describe "part_two/2" do
        test "returns the correct result for example" do
          assert :z ==
                  #{module_name}.part_one("#{name}.txt",
                    path: "test/advent_of_code/#{name}/"
                  )
        end

        test "returns the correct result" do
          assert :a ==
                   #{module_name}.part_two("#{name}.txt")
        end
      end
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
