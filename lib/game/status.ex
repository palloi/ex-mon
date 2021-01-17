defmodule ExMon.Game.Status do
  alias ExMon.Game

  def print_round_message(%{status: :started} = info) do
    IO.puts("\nThe game is started!\n")
    IO.inspect(info)
    IO.puts("---------")
  end

  def print_round_message(%{status: :continue, turn: player} = info) do
    IO.puts("\nIt's #{player} turn!\n")
    IO.inspect(info)
    IO.puts("---------")
  end

  def print_round_message(%{status: :game_over}) do
    IO.puts("\nThe game is over!\n")
    IO.inspect(Game.info())
    IO.puts("---------")
  end

  def print_wrong_move_message(move) do
    IO.puts("\nInvalid move: #{move}\n")
    IO.puts("---------")
  end

  def print_move_message(:computer, :attack, damage) do
    IO.puts("\nThe player attacked: dealing #{damage} damage.\n")
  end

  def print_move_message(:player, :attack, damage) do
    IO.puts("\nThe computer attacked: dealing #{damage} damage.\n")
  end

  def print_heal_message(player, :heal, life) do
    IO.puts("\nThe #{player} healled itself to #{life} life points.\n")
  end
end
