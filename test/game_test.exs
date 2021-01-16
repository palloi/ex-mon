defmodule ExMon.GameTest do
  use ExUnit.Case

  alias ExMon.{Game, Player}

  describe "start/2" do
    test "start the game state" do
      player = Player.build("Palloi", :punch, :kick, :heal)
      computer = Player.build("Robo", :punch, :kick, :heal)

      assert {:ok, _pid} = Game.start(computer, player)
    end

  end

  describe "info/0" do
    test "return the current game state" do
      player = Player.build("Palloi", :punch, :kick, :heal)
      computer = Player.build("Robo", :punch, :kick, :heal)

      Game.start(computer, player)
      expected_response = %{computer: %Player{life: 100, moves: %{move_avg: :kick, move_heal: :heal, move_rnd: :punch}, name: "Robo"}, player: %Player{life: 100, moves: %{move_avg: :kick, move_heal: :heal, move_rnd: :punch}, name: "Palloi"}, status: :started, turn: :player}

      assert Game.info() == expected_response
    end
  end

  describe "update/1" do
    test "returns the game state update" do
      player = Player.build("Palloi", :punch, :kick, :heal)
      computer = Player.build("Robo", :punch, :kick, :heal)

      Game.start(computer, player)
      expected_response = %{computer: %Player{life: 100, moves: %{move_avg: :kick, move_heal: :heal, move_rnd: :punch}, name: "Robo"}, player: %Player{life: 100, moves: %{move_avg: :kick, move_heal: :heal, move_rnd: :punch}, name: "Palloi"}, status: :started, turn: :player}

      assert Game.info() == expected_response

      new_state = %{computer: %Player{life: 100, moves: %{move_avg: :kick, move_heal: :heal, move_rnd: :punch}, name: "Robo"}, player: %Player{life: 100, moves: %{move_avg: :kick, move_heal: :heal, move_rnd: :punch}, name: "Palloi"}, status: :started, turn: :player}
      Game.update(new_state)
      expected_response = %{new_state | turn: :computer, status: :continue}

      assert Game.info() == expected_response
    end
  end

  describe "player/0" do
    test "return the player state info" do
      player = Player.build("Palloi", :punch, :kick, :heal)
      computer = Player.build("Robo", :punch, :kick, :heal)

      Game.start(computer, player)

      expected_player =  %Player{life: 100, moves: %{move_avg: :kick, move_heal: :heal, move_rnd: :punch}, name: "Palloi"}
      assert Game.player() == expected_player
    end
  end

  describe "turn/0" do
    test "return the turn state info" do
      player = Player.build("Palloi", :punch, :kick, :heal)
      computer = Player.build("Robo", :punch, :kick, :heal)

      Game.start(computer, player)

      assert Game.turn() == :player
    end
  end

  describe "fetch_player/0" do
    test "return the player state info" do
      player = Player.build("Palloi", :punch, :kick, :heal)
      computer = Player.build("Robo", :punch, :kick, :heal)

      Game.start(computer, player)
      expected_player = %Player{life: 100, moves: %{move_avg: :kick, move_heal: :heal, move_rnd: :punch}, name: "Palloi"}

      assert Game.fetch_player(:player) == expected_player
    end

    test "return the computer state info" do
      player = Player.build("Palloi", :punch, :kick, :heal)
      computer = Player.build("Robo", :punch, :kick, :heal)

      Game.start(computer, player)
      expected_computer =  %Player{life: 100, moves: %{move_avg: :kick, move_heal: :heal, move_rnd: :punch}, name: "Robo"}
      
      assert Game.fetch_player(:computer) == expected_computer
    end
  end
end