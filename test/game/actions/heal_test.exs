defmodule ExMon.Game.Actions.HealTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  alias ExMon.Game.Actions.{Attack, Heal}
  alias ExMon.{Player, Game}

  describe "heal_life/1" do
    setup do
      player = Player.build("Palloi", :punch, :kick, :heal)
      computer = Player.build("Robo", :kick, :punch, :heal)

      Game.start(computer, player)

      :ok
    end

    test "when heal a player" do
      capture_io(fn ->
        Attack.attack_opponent(:computer, :move_avg)
      end)

      life = :computer
        |> Game.fetch_player()
        |> Map.get(:life)

      messages = capture_io(fn ->
        Heal.heal_life(:computer)
      end)

      heal_life = :computer
        |> Game.fetch_player()
        |> Map.get(:life)

      assert life < heal_life
      assert messages =~ "The computer healled itself to #{heal_life} life points."
    end
  end
end
