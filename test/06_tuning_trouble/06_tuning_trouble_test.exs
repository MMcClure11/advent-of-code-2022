defmodule AdventOfCode.TuningTroubleTest do
  use ExUnit.Case

  alias AdventOfCode.TuningTrouble

  describe "part_one/2" do
    test "returns the correct result for example" do
      assert 7 ==
               TuningTrouble.part_one("06_tuning_trouble.txt",
                 path: "test/06_tuning_trouble/"
               )
    end

    test "returns the correct result" do
      assert 1912 ==
               TuningTrouble.part_one("06_tuning_trouble.txt")
    end
  end

  describe "part_two/2" do
    test "returns the correct result for example" do
      assert 19 ==
               TuningTrouble.part_two("06_tuning_trouble.txt",
                 path: "test/06_tuning_trouble/"
               )
    end

    test "returns the correct result" do
      assert 2122 ==
               TuningTrouble.part_two("06_tuning_trouble.txt")
    end
  end
end
