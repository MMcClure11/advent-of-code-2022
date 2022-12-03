defmodule AdventOfCode.RucksackReorganization do
  @moduledoc false

  import AdventOfCode

  @doc """
  --- Day 3: Rucksack Reorganization ---

  One Elf has the important job of loading all of the rucksacks with supplies for the jungle journey.
  Unfortunately, that Elf didn't quite follow the packing instructions, and so a few items now need to be rearranged.

  Each rucksack has two large compartments. All items of a given type are meant to go into exactly one of the two compartments.
  The Elf that did the packing failed to follow this rule for exactly one item type per rucksack.

  The Elves have made a list of all of the items currently in each rucksack (your puzzle input), but they need your help finding the errors.
  Every item type is identified by a single lowercase or uppercase letter (that is, a and A refer to different types of items).

  The list of items for each rucksack is given as characters all on a single line.
  A given rucksack always has the same number of items in each of its two compartments,
  so the first half of the characters represent items in the first compartment,
  while the second half of the characters represent items in the second compartment.

  For example, suppose you have the following list of contents from six rucksacks:

  vJrwpWtwJgWrhcsFMMfFFhFp
  jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
  PmmdzqPrVvPwwTWBwg
  wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
  ttgJtRGJQctTZtZT
  CrZsJsPPZsGzwwsLwLmpwMDw

    The first rucksack contains the items vJrwpWtwJgWrhcsFMMfFFhFp, which means its first compartment contains the items vJrwpWtwJgWr,
    while the second compartment contains the items hcsFMMfFFhFp. The only item type that appears in both compartments is lowercase p.
    The second rucksack's compartments contain jqHRNqRjqzjGDLGL and rsFMfFZSrLrFZsSL. The only item type that appears in both compartments is uppercase L.
    The third rucksack's compartments contain PmmdzqPrV and vPwwTWBwg; the only common item type is uppercase P.
    The fourth rucksack's compartments only share item type v.
    The fifth rucksack's compartments only share item type t.
    The sixth rucksack's compartments only share item type s.

  To help prioritize item rearrangement, every item type can be converted to a priority:

    Lowercase item types a through z have priorities 1 through 26.
    Uppercase item types A through Z have priorities 27 through 52.

  In the above example, the priority of the item type that appears in both compartments of each rucksack is
  16 (p), 38 (L), 42 (P), 22 (v), 20 (t), and 19 (s); the sum of these is 157.

  Find the item type that appears in both compartments of each rucksack. What is the sum of the priorities of those item types?

  Your puzzle answer was 8085.
  """
  @spec priorities_sum(String.t(), []) :: pos_integer()
  def priorities_sum(data, opts \\ []) do
    path = Keyword.get(opts, :path, "priv/input/")

    data
    |> read_input(path: path)
    |> String.split("\n")
    |> get_compartments()
    |> find_common_char()
    |> get_priorities()
    |> Enum.sum()
  end

  defp get_compartments(sack_items) do
    Enum.map(sack_items, fn x ->
      x
      |> String.split_at(round(String.length(x) / 2))
      |> Tuple.to_list()
    end)
  end

  defp find_common_char(compartments) do
      Enum.map(compartments, fn [compartment_1, compartment_2] ->
        c_1 = String.codepoints(compartment_1)

        Enum.find(c_1, fn x ->
          String.contains?(compartment_2, x)
        end)
      end)
  end

  defp get_priorities(chars) do
    priorities = priority_of_letter()

    Enum.map(chars, fn x ->
      if x == String.downcase(x) do
        priorities[x]
      else
        priorities[String.downcase(x)] + 26
      end
    end)
  end

  @chars ~w(a b c d e f g h i j k l m n o p q r s t u v w x y z)

  defp priority_of_letter() do
    @chars
    |> Enum.with_index(1)
    |> Enum.map(&Tuple.to_list(&1))
    |> Enum.reduce(%{}, fn x, acc ->
      Map.put(acc, List.first(x), List.last(x))
    end)
  end

  @doc """
  --- Part Two ---

  As you finish identifying the misplaced items, the Elves come to you with another issue.

  For safety, the Elves are divided into groups of three. Every Elf carries a badge that identifies their group.
  For efficiency, within each group of three Elves, the badge is the only item type carried by all three Elves.
  That is, if a group's badge is item type B, then all three Elves will have item type B somewhere in their rucksack,
  and at most two of the Elves will be carrying any other item type.

  The problem is that someone forgot to put this year's updated authenticity sticker on the badges.
  All of the badges need to be pulled out of the rucksacks so the new authenticity stickers can be attached.

  Additionally, nobody wrote down which item type corresponds to each group's badges.
  The only way to tell which item type is the right one is by finding the one item type that is common between all three Elves in each group.

  Every set of three lines in your list corresponds to a single group, but each group can have a different badge item type.
  So, in the above example, the first group's rucksacks are the first three lines:

  vJrwpWtwJgWrhcsFMMfFFhFp
  jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
  PmmdzqPrVvPwwTWBwg

  And the second group's rucksacks are the next three lines:

  wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
  ttgJtRGJQctTZtZT
  CrZsJsPPZsGzwwsLwLmpwMDw

  In the first group, the only item type that appears in all three rucksacks is lowercase r; this must be their badges.
  In the second group, their badge item type must be Z.

  Priorities for these items must still be found to organize the sticker attachment efforts:
  here, they are 18 (r) for the first group and 52 (Z) for the second group. The sum of these is 70.

  Find the item type that corresponds to the badges of each three-Elf group.

  What is the sum of the priorities of those item types?

  """
  @spec priorities_sum_2(String.t(), []) :: pos_integer()
  def priorities_sum_2(data, opts \\ []) do
    path = Keyword.get(opts, :path, "priv/input/")

    data
    |> read_input(path: path)
    |> String.split("\n")
    |> get_groupings()
    |> find_common_char_for_three_groups()
    |> get_priorities()
    |> Enum.sum()
  end

  defp get_groupings(sack_items) do
    Enum.chunk_every(sack_items, 3)
  end

  defp find_common_char_for_three_groups(groups) do
    groups
    |> Enum.map(fn [group1, group2, group3] ->
      group1
      |> String.codepoints()
      |> Enum.find(fn item -> String.contains?(group2, item) && String.contains?(group3, item) end)
    end)
  end
end
