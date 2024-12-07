defmodule Aoc2024.Day3 do
  def part_1(input_file) do
    File.read!(input_file)
    |> String.graphemes()
    |> Enum.reverse()
    |> Enum.chunk_while(
      "",
      fn e, acc ->
        if e == "m" do
          {:cont, e <> acc, ""}
        else
          {:cont, e <> acc}
        end
      end,
      fn
        "" -> {:cont, ""}
        acc -> {:cont, acc, ""}
      end
    )
    |> Enum.filter(&has_mul/1)
    |> Enum.map(&multiply/1)
    |> Enum.sum()
  end

  def part_2(input_file) do
    File.read!(input_file)
    |> String.graphemes()
    |> Enum.reverse()
    |> Enum.chunk_while(
      "",
      fn e, acc ->
        if e == "d" do
          {:cont, e <> acc, ""}
        else
          {:cont, e <> acc}
        end
      end,
      fn
        "" -> {:cont, ""}
        acc -> {:cont, acc, ""}
      end
    )
    |> Enum.filter(&(!String.starts_with?(&1,"don't()")))
    |> Enum.reduce(&(&1 <> &2))
    |> String.graphemes()
    |> Enum.reverse()
    |> Enum.chunk_while(
      "",
      fn e, acc ->
        if e == "m" do
          {:cont, e <> acc, ""}
        else
          {:cont, e <> acc}
        end
      end,
      fn
        "" -> {:cont, ""}
        acc -> {:cont, acc, ""}
      end
    )
    |> Enum.filter(&has_mul/1)
    |> Enum.map(&multiply/1)
    |> Enum.sum()
  end

  defp has_mul(val), do: val =~ ~r/mul\((\d*),(\d*)\)/

  defp multiply(val) do
    [[_match | nums] | _] = Regex.scan(~r/mul\((\d*),(\d*)\)/, val)

    nums
    |> Enum.map(&String.to_integer/1)
    |> Enum.reduce(&(&1 * &2))
  end
end
