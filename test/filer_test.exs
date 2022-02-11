defmodule FilerTest do
  use ExUnit.Case
  doctest Filer

  test "greets the world" do
    assert Filer.hello() == :world
  end
end
