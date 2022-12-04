defmodule AdventOfCode.CampCleanup do
  import AdventOfCode

  @doc """
  --- Day 4: Camp Cleanup ---

  Space needs to be cleared before the last supplies can be unloaded from the ships, and so several Elves have been assigned the job of cleaning up sections of the camp.
  Every section has a unique ID number, and each Elf is assigned a range of section IDs.

  However, as some of the Elves compare their section assignments with each other, they've noticed that many of the assignments overlap.
  To try to quickly find overlaps and reduce duplicated effort, the Elves pair up and make a big list of the section assignments for each pair (your puzzle input).

  For example, consider the following list of section assignment pairs:

  2-4,6-8
  2-3,4-5
  5-7,7-9
  2-8,3-7
  6-6,4-6
  2-6,4-8

  For the first few pairs, this list means:

    Within the first pair of Elves, the first Elf was assigned sections 2-4 (sections 2, 3, and 4), while the second Elf was assigned sections 6-8 (sections 6, 7, 8).
    The Elves in the second pair were each assigned two sections.
    The Elves in the third pair were each assigned three sections: one got sections 5, 6, and 7, while the other also got 7, plus 8 and 9.

  This example list uses single-digit section IDs to make it easier to draw; your actual list might contain larger numbers.
  Visually, these pairs of section assignments look like this:

  .234.....  2-4
  .....678.  6-8

  .23......  2-3
  ...45....  4-5

  ....567..  5-7
  ......789  7-9

  .2345678.  2-8
  ..34567..  3-7

  .....6...  6-6
  ...456...  4-6

  .23456...  2-6
  ...45678.  4-8

  Some of the pairs have noticed that one of their assignments fully contains the other.
  For example, 2-8 fully contains 3-7, and 6-6 is fully contained by 4-6.
  In pairs where one assignment fully contains the other, one Elf in the pair would be exclusively cleaning sections their partner will already be cleaning,
  so these seem like the most in need of reconsideration. In this example, there are 2 such pairs.

  In how many assignment pairs does one range fully contain the other?

  Your puzzle answer was 528.
  """
  @spec assignment_pairs(String.t(), []) :: pos_integer()
  def assignment_pairs(data, opts \\ []) do
    path = Keyword.get(opts, :path, "priv/input/")

    data
    |> parse_data(path)
    |> count_fully_contains()
  end

  defp parse_data(data, path) do
    data
    |> read_input(path: path)
    |> String.split("\n")
    |> to_integer_and_range()
  end

  defp to_integer_and_range(data) do
    data
    |> Enum.map(fn x ->
      x
      |> String.split(",")
      |> Enum.map(&String.split(&1, "-"))
      |> Enum.map(fn x ->
        Enum.map(x, fn y ->
          String.to_integer(y)
        end)

        # https://stackoverflow.com/questions/65135280/why-does-for-x-3-4-do-x-3-return-t-f-in-elixir/65136734#65136734
        # I was expecting [7, 9] but got '\a\t'
        # |> IO.inspect(charlists: :as_lists)
      end)
      |> Enum.map(fn x ->
        [first, last] = x
        %{first: first, last: last, range: Range.new(first, last)}
      end)
    end)
  end

  defp count_fully_contains(data) do
    Enum.reduce(data, 0, fn x, acc ->
      if fully_contained?(x) do
        acc + 1
      else
        acc
      end
    end)
  end

  defp fully_contained?(pairs) do
    [range_1, range_2] = pairs

    (Enum.member?(range_1.range, range_2.first) && Enum.member?(range_1.range, range_2.last)) ||
      (Enum.member?(range_2.range, range_1.first) && Enum.member?(range_2.range, range_1.last))
  end

end
