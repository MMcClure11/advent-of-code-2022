defmodule AdventOfCode.TreetopTreeHouse do
  @moduledoc false
  import AdventOfCode

  @doc """
  --- Day 8: Treetop Tree House ---

  The expedition comes across a peculiar patch of tall trees all planted carefully in a grid.
  The Elves explain that a previous expedition planted these trees as a reforestation effort.
  Now, they're curious if this would be a good location for a tree house.

  First, determine whether there is enough tree cover here to keep a tree house hidden.
  To do this, you need to count the number of trees that are visible from outside the grid when looking directly along a row or column.

  The Elves have already launched a quadcopter to generate a map with the height of each tree (your puzzle input). For example:

  30373
  25512
  65332
  33549
  35390

  Each tree is represented as a single digit whose value is its height, where 0 is the shortest and 9 is the tallest.

  A tree is visible if all of the other trees between it and an edge of the grid are shorter than it.
  Only consider trees in the same row or column; that is, only look up, down, left, or right from any given tree.

  All of the trees around the edge of the grid are visible - since they are already on the edge, there are no trees to block the view.
  In this example, that only leaves the interior nine trees to consider:

    The top-left 5 is visible from the left and top. (It isn't visible from the right or bottom since other trees of height 5 are in the way.)
    The top-middle 5 is visible from the top and right.
    The top-right 1 is not visible from any direction; for it to be visible, there would need to only be trees of height 0 between it and an edge.
    The left-middle 5 is visible, but only from the right.
    The center 3 is not visible from any direction; for it to be visible, there would need to be only trees of at most height 2 between it and an edge.
    The right-middle 3 is visible from the right.
    In the bottom row, the middle 5 is visible, but the 3 and 4 are not.

  With 16 trees visible on the edge and another 5 visible in the interior, a total of 21 trees are visible in this arrangement.

  Consider your map; how many trees are visible from outside the grid?

  Your puzzle answer was 1870.
  """
  @spec part_one(String.t(), []) :: pos_integer()
  def part_one(data, opts \\ []) do
    path = Keyword.get(opts, :path, "priv/input/")

    grid = parse_data(data, path)

    # width of grid, minus 1 to get indices
    max_x = Enum.count(List.first(grid)) - 1
    # height of grid, minus 1 to get indices
    max_y = Enum.count(grid) - 1

    visible_trees_inside_grid =
      for y <- 1..(max_y - 1),
          x <- 1..(max_x - 1),
          visible?(grid, {x, y}, max_x, max_y) do
        {x, y}
      end

    Enum.count(visible_trees_inside_grid) +
      trees_on_edges(
        number_visible_on_west_and_east(grid),
        number_visible_on_north_and_south(grid)
      )
  end

  defp parse_data(data, path) do
    data
    |> read_input(path: path)
    |> String.split("\n")
    |> Enum.map(fn line ->
      line
      |> String.split("", trim: true)
      |> Enum.map(&String.to_integer/1)
    end)
  end

  defp visible?(grid, {x, y}, max_x, max_y) do
    visible_from_north(grid, {x, y}) || visible_from_south(grid, {x, y}, max_y) ||
      visible_from_east(grid, {x, y}) || visible_from_west(grid, {x, y}, max_x)
  end

  defp visible_from_north(grid, {x, y}) do
    height_of_tree = get_tree_height(grid, {x, y})

    # check height of each tree on y-axis in same column as given tree
    # (y - 1)..0//-1 the range, counting down from the top, subtract 1 to exclude current tree
    Enum.reduce((y - 1)..0//-1, true, fn new_y, acc ->
      acc and get_tree_height(grid, {x, new_y}) < height_of_tree
    end)
  end

  defp visible_from_south(grid, {x, y}, max_y) do
    height = get_tree_height(grid, {x, y})

    # check height of each tree on y-axis in same column as given tree
    # (y + 1)..max_y the range, counting up from the bottom, add 1 to exclude current tree
    Enum.reduce((y + 1)..max_y, true, fn new_y, acc ->
      acc and get_tree_height(grid, {x, new_y}) < height
    end)
  end

  defp visible_from_east(grid, {x, y}) do
    height = get_tree_height(grid, {x, y})

    # check height of each tree on x-axis in same row as given tree
    # (x - 1)..0//-1 the range, counting down to the left, subtract 1 to exclude current tree
    Enum.reduce((x - 1)..0//-1, true, fn new_x, acc ->
      acc and get_tree_height(grid, {new_x, y}) < height
    end)
  end

  defp visible_from_west(grid, {x, y}, max_x) do
    height = get_tree_height(grid, {x, y})

    # check height of each tree on x-axis in same row as given tree
    # (x + 1)..max_x the range, counting up to the right, subtract 1 to exclude current tree
    Enum.reduce((x + 1)..max_x, true, fn new_x, acc ->
      acc and get_tree_height(grid, {new_x, y}) < height
    end)
  end

  defp get_tree_height(grid, {x, y}) do
    # first find y -> the row the tree is in
    # find x -> the column the tree is in within that row
    grid |> Enum.at(y) |> Enum.at(x)
  end

  defp number_visible_on_west_and_east(grid) do
    # number of rows, times 2
    Enum.count(grid) * 2
  end

  defp number_visible_on_north_and_south(grid) do
    # number of columns
    row_length =
      grid
      |> List.first()
      |> Enum.count()

    row_length * 2
  end

  defp trees_on_edges(west_and_east, north_and_south) do
    # remove duplicate of the corners
    west_and_east + north_and_south - 4
  end
end
