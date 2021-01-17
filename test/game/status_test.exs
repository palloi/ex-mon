defmodule ExMon.Game.StatusTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  alias ExMon.Player
  alias ExMon.Game
  alias ExMon.Game.Status

  describe "print_round_message/1" do
    test "when message to started" do
      messages = capture_io(fn ->
        Status.print_round_message(%{status: :started})
      end)

      assert messages =~ "The game is started!"
    end

    test "when message to player turn" do
      messages = capture_io(fn ->
        Status.print_round_message(%{status: :continue, turn: "Palloi"})
      end)

      assert messages =~ "It's Palloi turn!"
    end

    test "when message to game over" do
      player = Player.build("Palloi", :punch, :kick, :heal)
      computer = Player.build("Robo", :punch, :kick, :heal)

      Game.start(computer, player)

      messages = capture_io(fn ->
        Status.print_round_message(%{status: :game_over})
      end)

      assert messages =~ "The game is over!"
    end
  end

  describe "print_wrong_move_message/1" do
    test "when message to invalid move" do
      messages = capture_io(fn ->
        Status.print_wrong_move_message(:bosta)
      end)

      assert messages =~ "Invalid move: bosta"
    end
  end

  describe "print_move_message/3" do
    test "when message to computer atack" do
      messages = capture_io(fn ->
        Status.print_move_message(:player, :attack, 50)
      end)

      assert messages =~ "The computer attacked: dealing 50 damage."
    end

    test "when message to player atack" do
      messages = capture_io(fn ->
        Status.print_move_message(:computer, :attack, 80)
      end)

      assert messages =~ "The player attacked: dealing 80 damage."
    end
  end

  describe "print_heal_message/3" do
    test "when message to healled" do
      messages = capture_io(fn ->
        Status.print_heal_message(:player, :heal, 94)
      end)

      assert messages =~ "The player healled itself to 94 life points."
    end
  end
end
