defmodule AdventOfCode do
  @moduledoc """
  Documentation for `AdventOfCode`.
  """

  def read_input(filename, opts \\ []) do
    path = Keyword.get(opts, :path, "priv/input/")
    File.read!("#{path}#{filename}")
  end
end
