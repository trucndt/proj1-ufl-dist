defmodule Proj1Test do
  use ExUnit.Case
  doctest Proj1

  test "2 elements start from 3" do
    assert Worker.checkSumToSquare(3, 2) == true
  end

  test "24 elements start from 25" do
    assert Worker.checkSumToSquare(25, 24) == true
  end

  test "24 elements start from 20" do
    assert Worker.checkSumToSquare(20, 24) == true
  end

  test "24 elements start from 9" do
    assert Worker.checkSumToSquare(9, 24) == true
  end
end
