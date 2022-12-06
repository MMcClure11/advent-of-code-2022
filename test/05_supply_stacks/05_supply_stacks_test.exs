defmodule AdventOfCode.SupplyStacksTest do
  use ExUnit.Case

  alias AdventOfCode.SupplyStacks

  describe "find_top_crates/2" do
    test "returns the correct result for example" do
      assert "CMZ" ==
               SupplyStacks.find_top_crates("05_supply_stacks.txt",
                 path: "test/05_supply_stacks/"
               )
    end

    test "returns the correct result" do
      assert "VJSFHWGFT" ==
               SupplyStacks.find_top_crates("05_supply_stacks.txt")
    end
  end
end
