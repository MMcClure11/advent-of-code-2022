defmodule AdventOfCode.TreetopTreeHouseTest do
  use ExUnit.Case

  alias AdventOfCode.TreetopTreeHouse

  describe "part_one/2" do
    test "returns the correct result for example" do
      assert 21 ==
               TreetopTreeHouse.part_one("08_treetop_tree_house.txt",
                 path: "test/advent_of_code/08_treetop_tree_house/"
               )
    end

    test "returns the correct result" do
      assert 1870 ==
               TreetopTreeHouse.part_one("08_treetop_tree_house.txt")
    end
  end
end
