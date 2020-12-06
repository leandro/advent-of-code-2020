defmodule AdventOfCode2020 do
  defmodule Day1 do
    defmodule PartOne do
      @input_data (
        File.read!("./input.txt")
        |> String.split("\n")
        |> Enum.map(&String.to_integer/1)
      )

      def get_answer do
        @input_data
        |> Enum.reduce_while(@input_data, fn number, acc ->
            case get_pair_that_sums_2020(number, @input_data) do
              :error -> {:cont, acc}
              {:ok, pair} -> {:halt, pair}
            end
          end)
        |> (&(elem(&1, 0) * elem(&1, 1))).()
      end

      defp get_pair_that_sums_2020(_, []), do: :error

      defp get_pair_that_sums_2020(number, [head | tail]) do
        case number + head do
          2020 -> {:ok, {number, head}}
          _ -> get_pair_that_sums_2020(number, tail)
        end
      end
    end
  end
end

IO.inspect(AdventOfCode2020.Day1.PartOne.get_answer())
