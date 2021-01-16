defmodule ExMonTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  alias ExMon.Player

  describe "create_player/4" do
    test "returns a player" do
      expected_player = %Player{
        life: 100,
        moves: %{move_avg: :punch, move_heal: :heal, move_rnd: :kick},
        name: "Palloi"
      }

      assert ExMon.create_player("Palloi", :kick, :punch, :heal) == expected_player
    end
  end

  describe "start_game/1" do
    test "when the game started, return a message" do
      player = Player.build("Palloi", :punch, :kick, :heal)

      messages = capture_io(fn ->
        assert ExMon.start_game(player) == :ok
      end)

      assert messages =~ "The game is started"
      assert messages =~ "status: :started"
      assert messages =~ "turn: :player"
    end
  end

  describe "make_move/1" do
    setup do
      player = Player.build("Palloi", :punch, :kick, :heal)

      capture_io(fn ->
        ExMon.start_game(player)
      end)

      :ok
    end

    test "when the move is valid, do the move and the computer makes a move" do
      messages = capture_io(fn ->
        ExMon.make_move(:kick)
      end)

      assert messages =~ "The player attacked"
      assert messages =~ "It's computer turn!"
      assert messages =~ "It's player turn!"
      assert messages =~ "status: :continue"
    end

    test "when the move is invalid, returns an error message" do
      messages = capture_io(fn ->
        ExMon.make_move(:bosta)
      end)

      assert messages =~ "Invalid move: bosta"
    end
  end
end
