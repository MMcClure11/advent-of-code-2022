defmodule AdventOfCode.CalorieCountingTest do
  use ExUnit.Case

  alias AdventOfCode.CalorieCounting

  describe "count_calories/0" do
    test "returns the correct result" do
      assert 71780 == CalorieCounting.count_calories()
    end
  end

  describe "count_calories_2/0" do
    test "returns the correct result" do
      assert 212489 == CalorieCounting.count_calories_2()
    end
  end
end
