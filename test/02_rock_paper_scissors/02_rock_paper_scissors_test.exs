defmodule AdventOfCode.RockPaperScissorsTest do
  use ExUnit.Case

  alias AdventOfCode.RockPaperScissors

  describe "calculate_score/2" do
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

  describe "calculate_score_2/2" do
    test "returns the correct result for example" do
      assert 12 ==
               RockPaperScissors.calculate_score_2("02_rock_paper_scissors.txt",
                 path: "test/02_rock_paper_scissors/"
               )
    end

    test "returns the correct result" do
      assert 16098 == RockPaperScissors.calculate_score_2("02_rock_paper_scissors.txt")
    end
  end
end
