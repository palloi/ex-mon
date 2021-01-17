defmodule ExMon.Game.ActionsTest do
  use ExUnit.Case
  
  import ExUnit.CaptureIO

  alias ExMon.{Game, Player}
  alias ExMon.Game.Actions

  describe "attack/1" do
    test "when player atack" do
      player = Player.build("Palloi", :punch, :kick, :heal)
      computer = Player.build("Robo", :punch, :kick, :heal)

      Game.start(computer, player)

      assert Game.turn() == :player

      capture_io(fn ->
        Actions.attack(:move_rnd)
      end)

      life =
        Game.fetch_player(:computer)
        |> Map.get(:life)

      assert life < 100
    end
  end

  describe "heal/0" do
    test "when player healled" do
      player = Player.build("Palloi", :punch, :kick, :heal)
      computer = Player.build("Robo", :punch, :kick, :heal)

      Game.start(computer, player)

      capture_io(fn ->
        Actions.attack(:move_avg)
      end)
      
      attack_life =
        Game.fetch_player(:computer)
        |> Map.get(:life)

      assert attack_life < 100

      messages = capture_io(fn ->
        Actions.heal()
      end)

      heal_life =
        Game.fetch_player(:computer)
        |> Map.get(:life)

      assert messages =~ "The computer healled itself to #{heal_life} life points."
      assert heal_life > attack_life
    end
  end

  describe "fetch_move/1" do
    test "when get player move" do
      player = Player.build("Palloi", :punch, :kick, :heal)
      computer = Player.build("Robo", :punch, :kick, :heal)

      Game.start(computer, player)

      assert Actions.fetch_move(:kick) == {:ok, :move_avg}
    end
  end
end
