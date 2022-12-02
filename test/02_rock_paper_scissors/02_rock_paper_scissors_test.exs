defmodule AdventOfCode.RockPaperScissorsTest do
  use ExUnit.Case

  alias AdventOfCode.RockPaperScissors

  describe "count_calories/2" do
    test "returns the correct result for example" do
      assert 15 ==
               RockPaperScissors.calculate_score("02_rock_paper_scissors.txt",
                 path: "test/02_rock_paper_scissors/"
               )
    end

    test "returns the correct result" do
      assert 15572 == RockPaperScissors.calculate_score("02_rock_paper_scissors.txt")
    end
  end
end
