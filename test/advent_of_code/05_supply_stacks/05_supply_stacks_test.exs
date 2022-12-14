defmodule AdventOfCode.SupplyStacksTest do
  use ExUnit.Case

  alias AdventOfCode.SupplyStacks

  describe "find_top_crates/2" do
    test "returns the correct result for example" do
      crates = %{
        1 => ~w(N  Z),
        2 => ~w(D C M),
        3 => ~w(P)
      }

      assert "CMZ" ==
               SupplyStacks.find_top_crates("05_supply_stacks.txt",
                 path: "test/advent_of_code/05_supply_stacks/",
                 crates: crates
               )
    end

    test "returns the correct result" do
      assert "VJSFHWGFT" ==
               SupplyStacks.find_top_crates("05_supply_stacks.txt")
    end
  end

  describe "find_top_crates_two/2" do
    test "returns the correct result for example" do
      crates = %{
        1 => ~w(N  Z),
        2 => ~w(D C M),
        3 => ~w(P)
      }

      assert "MCD" ==
               SupplyStacks.find_top_crates("05_supply_stacks.txt",
                 path: "test/advent_of_code/05_supply_stacks/",
                 reverse?: false,
                 crates: crates
               )
    end

    test "returns the correct result" do
      assert "LCTQFBVZV" ==
               SupplyStacks.find_top_crates("05_supply_stacks.txt", reverse?: false)
    end
  end
end
