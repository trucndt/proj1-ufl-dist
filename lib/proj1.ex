defmodule Proj1 do
  def findPerfectSquare(n, k) do
    for x <- 1..n do
      spawn(Worker, :squareSumList, [self(), x, k])
#      Worker.squareSumList(self(), x, k)
    end

    waitForWorkers(0, n)
  end

  def waitForWorkers(count, n) do
    if count < n do
      receive do
        :finish -> waitForWorkers(count + 1, n)
      end
    end
  end
end

defmodule Worker do
  def sumOfSquares(n) do
    n * (n + 1) * (2 * n + 1) / 6
  end

  def squareSumList(boss, start, k) do
    sum = sumOfSquares(start + k - 1) - sumOfSquares(start - 1)

    rootTrunc = trunc(:math.sqrt(sum))

    if rootTrunc * rootTrunc == sum do
      IO.inspect(start)
    end

    send(boss, :finish)
  end
end
