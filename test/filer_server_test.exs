defmodule FilerServerTest do
  use ExUnit.Case
  doctest Filer.Server

  test "greets the world" do
    assert Filer.hello() == :world
  end
end
