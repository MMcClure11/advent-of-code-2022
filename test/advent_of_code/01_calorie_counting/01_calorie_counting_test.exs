defmodule AdventOfCode.CalorieCountingTest do
  use ExUnit.Case

  alias AdventOfCode.CalorieCounting

  describe "count_calories/2" do
    test "returns the correct result for example" do
      assert 24000 ==
               CalorieCounting.count_calories("01_calorie_counting.txt",
                 path: "test/advent_of_code/01_calorie_counting/"
               )
    end

    test "returns the correct result" do
      assert 71780 == CalorieCounting.count_calories("01_calorie_counting.txt")
    end
  end

  describe "count_calories_2/2" do
    test "returns the correct result for example" do
      assert 45000 ==
               CalorieCounting.count_calories_2("01_calorie_counting.txt",
                 path: "test/advent_of_code/01_calorie_counting/"
               )
    end

    test "returns the correct result" do
      assert 212_489 == CalorieCounting.count_calories_2("01_calorie_counting.txt")
    end
  end
end
