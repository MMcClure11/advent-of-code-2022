defmodule AdventOfCode do
  @moduledoc """
  Documentation for `AdventOfCode`.
  """

  def read_input(filename) do
    File.read!("priv/input/#{filename}")
  end
end
