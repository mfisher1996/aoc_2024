defmodule Aoc2024.Day1 do
  def part_1(input_file) do
    {left, right, _count} =
      File.read!(input_file)
      |> String.split(["\n", "   "])
      |> Enum.filter(&(&1 != ""))
      |> Enum.map(&String.to_integer/1)
      |> Enum.reduce({[], [], 0}, &red/2)

    left_s = Enum.sort(left)
    right_s = Enum.sort(right)

    Enum.zip(left_s, right_s)
    |> Enum.reduce(0, fn val, acc ->
      case val do
        {left, right} when left > right -> left - right
        {left, right} -> right - left
      end + acc
    end)
  end

  def part_2(input_file) do
    {left, right, _count} =
      File.read!(input_file)
      |> String.split(["\n", "   "])
      |> Enum.filter(&(&1 != ""))
      |> Enum.map(&String.to_integer/1)
      |> Enum.reduce({[], [], 0}, &red/2)

    left_map =
      left
      |> Map.new(&{&1, 0})

    left_map =
      left
      |> Enum.reduce(left_map, &%{&2 | &1 => &2[&1] + 1})

    right
    |> Enum.filter(&(left_map[&1] != nil))
    |> Enum.reduce(0, &(left_map[&1] * &1 + &2))
  end

  defp red(val, {left, right, count}) do
    case rem(count, 2) do
      0 -> {[val | left], right, count + 1}
      1 -> {left, [val | right], count + 1}
    end
  end
end
