defmodule ExMon.Game.Actions.AttackTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  alias ExMon.Game.Actions.Attack
  alias ExMon.{Player, Game}

  describe "attack_opponent/2" do
    setup do
      player = Player.build("Palloi", :punch, :kick, :heal)
      computer = Player.build("Robo", :kick, :punch, :heal)

      Game.start(computer, player)

      :ok
    end

    test "when player to attack computer" do
      life = :computer
        |> Game.fetch_player()
        |> Map.get(:life)

      messages = capture_io(fn ->
        Attack.attack_opponent(:computer, :move_avg)
      end)

      attacked_life = :computer
        |> Game.fetch_player()
        |> Map.get(:life)

      assert life > attacked_life
      assert messages =~ "The player attacked: dealing #{life - attacked_life} damage."
    end

    test "when computer to attack player" do
      life = :player
        |> Game.fetch_player()
        |> Map.get(:life)

      messages = capture_io(fn ->
        Attack.attack_opponent(:player, :move_rnd)
      end)

      attacked_life = :player
        |> Game.fetch_player()
        |> Map.get(:life)

      assert life > attacked_life
      assert messages =~ "The computer attacked: dealing #{life - attacked_life} damage."
    end
  end
end
