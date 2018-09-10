defmodule Proj1Test do
  use ExUnit.Case
  doctest Proj1

  test "case 1: 3 2" do
    assert Proj1.startBoss(3, 2, 4) |> Enum.sort == [3]
  end
end
