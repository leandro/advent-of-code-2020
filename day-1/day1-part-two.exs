defmodule AdventOfCode2020 do
  defmodule Day1 do
    defmodule PartTwo do
      @input_data (
        File.read!("./input.txt")
        |> String.split("\n")
        |> Enum.map(&String.to_integer/1)
      )

      def get_answer do
        @input_data
        |> Enum.reduce_while({:cont, @input_data}, fn number1, acc2 ->
          temp_acc =
            Enum.reduce_while(@input_data, {:cont, @input_data}, fn number2, {:cont, acc2} ->
              case get_triple_that_sums_2020(number1, number2, @input_data) do
                :error -> {:cont, {:cont, acc2}}
                {:ok, triple} -> {:halt, {:halt, triple}}
              end
            end)

          with {:cont, _} <- temp_acc, do: {:cont, acc2}
        end)
        |> Tuple.to_list()
        |> Enum.reduce(&Kernel.*/2)
      end

      defp get_triple_that_sums_2020(_, _, []), do: :error
      defp get_triple_that_sums_2020(number1, number2, _) when number1 + number2 > 2020, do: :error

      defp get_triple_that_sums_2020(number1, number2, [head | tail]) do
        case number1 + number2 + head do
          2020 -> {:ok, {number1, number2, head}}
          _ -> get_triple_that_sums_2020(number1, number2, tail)
        end
      end
    end
  end
end

IO.inspect(AdventOfCode2020.Day1.PartTwo.get_answer())
