defmodule AdventOfCode.CampCleanupTest do
  use ExUnit.Case

  alias AdventOfCode.CampCleanup

  describe "assignment_pairs/2" do
    test "returns the correct result for example" do
      assert 2 ==
               CampCleanup.assignment_pairs("04_camp_cleanup.txt",
                 path: "test/04_camp_cleanup/"
               )
    end

    test "returns the correct result" do
      assert 528 ==
               CampCleanup.assignment_pairs("04_camp_cleanup.txt")
    end
  end

  describe "assignment_pairs_2/2" do
    test "returns the correct result for example" do
      assert 4 ==
               CampCleanup.assignment_pairs_2("04_camp_cleanup.txt",
                 path: "test/04_camp_cleanup/"
               )
    end

    test "returns the correct result" do
      assert 881 ==
               CampCleanup.assignment_pairs_2("04_camp_cleanup.txt")
    end
  end
end
