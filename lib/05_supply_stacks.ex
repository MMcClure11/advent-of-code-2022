defmodule AdventOfCode.SupplyStacks do
  import AdventOfCode

  @doc """
  --- Day 5: Supply Stacks ---

  The expedition can depart as soon as the final supplies have been unloaded from the ships.
  Supplies are stored in stacks of marked crates, but because the needed supplies are buried under many other crates, the crates need to be rearranged.

  The ship has a giant cargo crane capable of moving crates between stacks.
  To ensure none of the crates get crushed or fall over, the crane operator will rearrange them in a series of carefully-planned steps.
  After the crates are rearranged, the desired crates will be at the top of each stack.

  The Elves don't want to interrupt the crane operator during this delicate procedure,
  but they forgot to ask her which crate will end up where, and they want to be ready to unload them as soon as possible so they can embark.

  They do, however, have a drawing of the starting stacks of crates and the rearrangement procedure (your puzzle input). For example:

      [D]
  [N] [C]
  [Z] [M] [P]
   1   2   3

  move 1 from 2 to 1
  move 3 from 1 to 3
  move 2 from 2 to 1
  move 1 from 1 to 2

  In this example, there are three stacks of crates.
  Stack 1 contains two crates: crate Z is on the bottom, and crate N is on top.
  Stack 2 contains three crates; from bottom to top, they are crates M, C, and D. Finally, stack 3 contains a single crate, P.

  Then, the rearrangement procedure is given. In each step of the procedure, a quantity of crates is moved from one stack to a different stack.
  In the first step of the above rearrangement procedure, one crate is moved from stack 2 to stack 1, resulting in this configuration:

  [D]
  [N] [C]
  [Z] [M] [P]
   1   2   3

  In the second step, three crates are moved from stack 1 to stack 3. Crates are moved one at a time, so the first crate to be moved (D) ends up below the second and third crates:

         [Z]
         [N]
     [C] [D]
     [M] [P]
  1   2   3

  Then, both crates are moved from stack 2 to stack 1. Again, because crates are moved one at a time, crate C ends up below crate M:

          [Z]
          [N]
  [M]     [D]
  [C]     [P]
   1   2   3

  Finally, one crate is moved from stack 1 to stack 2:

          [Z]
          [N]
          [D]
  [C] [M] [P]
   1   2   3

  The Elves just need to know which crate will end up on top of each stack; in this example, the top crates are C in stack 1, M in stack 2, and Z in stack 3,
  so you should combine these together and give the Elves the message CMZ.

  After the rearrangement procedure completes, what crate ends up on top of each stack?

  Your puzzle answer was VJSFHWGFT.

    --- Part Two ---

  As you watch the crane operator expertly rearrange the crates, you notice the process isn't following your prediction.

  Some mud was covering the writing on the side of the crane, and you quickly wipe it away.
  The crane isn't a CrateMover 9000 - it's a CrateMover 9001.

  The CrateMover 9001 is notable for many new and exciting features: air conditioning, leather seats, an extra cup holder,
  and the ability to pick up and move multiple crates at once.

  Again considering the example above, the crates begin in the same configuration:

      [D]
  [N] [C]
  [Z] [M] [P]
  1   2   3

  Moving a single crate from stack 2 to stack 1 behaves the same as before:

  [D]
  [N] [C]
  [Z] [M] [P]
  1   2   3

  However, the action of moving three crates from stack 1 to stack 3 means that those three moved crates stay in the same order, resulting in this new configuration:

        [D]
        [N]
    [C] [Z]
    [M] [P]
  1   2   3

  Next, as both crates are moved from stack 2 to stack 1, they retain their order as well:

          [D]
          [N]
  [C]     [Z]
  [M]     [P]
  1   2   3

  Finally, a single crate is still moved from stack 1 to stack 2, but now it's crate C that gets moved:

          [D]
          [N]
          [Z]
  [M] [C] [P]
  1   2   3

  In this example, the CrateMover 9001 has put the crates in a totally different order: MCD.

  Before the rearrangement process finishes, update your simulation so that the Elves know where they should stand to be ready to unload the final supplies. After the rearrangement procedure completes, what crate ends up on top of each stack?

  Your puzzle answer was LCTQFBVZV.
  """
  @crates %{
    1 => ~w(W P G Z V S B),
    2 => ~w(F Z C B V J),
    3 => ~w(C D Z N H M L V),
    4 => ~w(B J F P Z M D L),
    5 => ~w(H Q B J G C F V),
    6 => ~w(B L S T Q F G),
    7 => ~w(V Z C G L),
    8 => ~w(G L N),
    9 => ~w(C H F J)
  }

  @spec find_top_crates(String.t(), []) :: String.t()
  def find_top_crates(data, opts \\ []) do
    path = Keyword.get(opts, :path, "priv/input/")
    initial_crates = Keyword.get(opts, :crates, @crates)
    reverse? = Keyword.get(opts, :reverse?, true)

    data
    |> parse_data(path)
    |> reorder_crates(initial_crates, reverse?)
    |> get_top_crates()
  end

  defp parse_data(data, path) do
    data
    |> read_input(path: path)
    |> String.split("\n\n")
    |> List.last()
    |> String.split("\n")
    |> Enum.map(fn move ->
      [_move, amount, _from, from, _to, to] = String.split(move, " ")
      {String.to_integer(amount), String.to_integer(from), String.to_integer(to)}
    end)
  end

  defp reorder_crates(moves, initial_crates, reverse?) do
    Enum.reduce(moves, initial_crates, fn move, crates ->
      {amount, from, to} = move
      {crates_taken, new_from_stack} = Enum.split(crates[from], amount)
      new_to_stack = create_new_stack(crates_taken, crates[to], reverse?)

      crates
      |> Map.put(to, new_to_stack)
      |> Map.put(from, new_from_stack)
    end)
  end

  defp create_new_stack(crates_taken, crates_to, reverse?) do
    if reverse? do
      Enum.reverse(crates_taken) ++ crates_to
    else
      crates_taken ++ crates_to
    end
  end

  defp get_top_crates(crates) do
    Enum.reduce(crates, "", fn stack, acc ->
      {_, crates_in_stack} = stack
      acc <> List.first(crates_in_stack)
    end)
  end
end
