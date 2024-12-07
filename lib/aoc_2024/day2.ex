defmodule Aoc2024.Day2 do
  def part_1(input_file) do
    levels =
      File.read!(input_file)
      |> String.split(["\n"])
      |> Enum.filter(&(&1 != ""))
      |> Enum.map(&String.split(&1, [" "]))

    levels
    |> Enum.filter(&safe_level/1)
    |> Enum.count()
  end

  def part_2(input_file) do
    levels =
      File.read!(input_file)
      |> String.split(["\n"])
      |> Enum.filter(&(&1 != ""))
      |> Enum.map(&String.split(&1, [" "]))
      |> Enum.map(fn v -> Enum.map(v, &String.to_integer/1) end)

    levels
    |> Enum.filter(&kinda_safe/1)
    |> Enum.count()
  end

  def unsafe_step([first, second]), do: abs(first - second) >= 4

  def safe_level(level) do
    chunks =
      level
      |> Enum.chunk_every(2, 1, :discard)

    !Enum.any?(chunks |> Enum.map(&unsafe_step/1)) &&
      1 ==
        chunks
        |> Enum.map(&direction/1)
        |> Enum.uniq()
        |> Enum.count()
  end

  def kinda_safe(level) do
    chunks =
      level
      |> Enum.chunk_every(2, 1, :discard)

    bad_read =
      chunks
      |> Enum.find_index(fn v -> unsafe_step(v) end)

    bad_read =
      if bad_read == nil do
        directions =
          chunks
          |> Enum.map(&direction/1)

        get_bad(directions)
      else
        bad_read
      end

    bad_read == nil ||
      safe_level(level |> without(bad_read)) ||
      safe_level(level |> without(bad_read + 1))
  end

  defp direction([first, second]) do
    cond do
      first < second -> :up
      first > second -> :down
      true -> :invalid
    end
  end

  defp get_bad([first | rest]) do
    idx =
      rest
      |> Enum.find_index(&(&1 != first))

    cond do
      idx == 0 && Enum.at(rest, 1) == Enum.at(rest, 0) -> 0
      idx != nil -> idx + 1
      true -> idx
    end
  end

  defp without(list, idx) do
    {before, rest} =
      list
      |> Enum.split(idx)

    Enum.concat(before, Enum.drop(rest, 1))
  end
end
