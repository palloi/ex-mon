defmodule ExMon.Game.Status do
	alias ExMon.Game

	def print_round_message() do
		IO.puts("\nThe game is started!\n")
		IO.inspect(Game.info())
		IO.puts("---------")
	end

	def print_wrong_move_message(move) do
		IO.puts("\nInvalid move: #{move}\n")
		IO.puts("---------")
	end
end