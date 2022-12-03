defmodule AdventOfCode.RucksackReorganizationTest do
  use ExUnit.Case

  alias AdventOfCode.RucksackReorganization

  describe "priorities_sum/2" do
    test "returns the correct result for example" do
      assert 157 ==
               RucksackReorganization.priorities_sum("03_rucksack_reorganization.txt",
                 path: "test/03_rucksack_reorganization/"
               )
    end

    test "returns the correct result" do
      assert 8085 ==
               RucksackReorganization.priorities_sum("03_rucksack_reorganization.txt")
    end
  end

  describe "priorities_sum_2/2" do
    test "returns the correct result for example" do
      assert 70 ==
               RucksackReorganization.priorities_sum_2("03_rucksack_reorganization.txt",
                 path: "test/03_rucksack_reorganization/"
               )
    end

    test "returns the correct result" do
      assert 2515 ==
               RucksackReorganization.priorities_sum_2("03_rucksack_reorganization.txt")
    end
  end
end
