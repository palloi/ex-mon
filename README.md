# ExMon

[![](https://github.com/actions/palloi/workflows/Test/badge.svg)](https://github.com/actions/palloi/actions)

**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `ex_mon` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:ex_mon, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/ex_mon](https://hexdocs.pm/ex_mon).

 
 player = ExMon.create_player("Player", :punch, :kick, :heal)
 ExMon.start_game(player)
 ExMon.make_move(:kick)
 ExMon.Game.info()
 
