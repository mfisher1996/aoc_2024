defmodule Aoc2024.Day4 do
  def part_1(input_file) do
    File.read!(input_file)
    |> String.split("\n")
    |> Enum.chunk_every(4, 1, :discard)
    |> Enum.map(&Enum.map(&1, fn val -> String.graphemes(val) end))
  end


  defp find_xmas([line1, line2, line3, line4]) do 
    pos = {0 , 0}
    
  end

  defp find_xmas({x,y}, arrs) do 
    case Enum.at(Enum.at(arrs,y), x) do 
      "X" -> check_letters({x,y},arrs)
      "S" -> check_letters({x,y},arrs)
      _ -> find_xmas({rem(x + 1, 10), rem(y + 1, 4)}, arrs)
    end
  end

  defp find_xmas({4,10}, [line1, line2, line3, line4]) do 
    
  end

  # probably don't need, but cool we can do
  defp find_xmas(line), do: line =~ ~r/XMAS/

  defp check_letters({x,y}, arrs, off \\ 0) do
  end
end
