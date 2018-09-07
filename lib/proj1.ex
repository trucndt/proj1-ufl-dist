defmodule Proj1 do
  def startBoss(n, k, noActors) do
    workUnit = div(n, noActors)
    remainder = rem(n, noActors)
    runActors = if workUnit == 0, do: remainder, else: noActors

    ### Calculate and assisn work unit to each actor
    for act <- 1..runActors do
      if act <= remainder do
        start = (act - 1) * (workUnit + 1) + 1
        spawn(Worker, :findPerfectSquare, [self(), start, workUnit + 1, k])
      else
        start = remainder * (workUnit + 1) + (act - 1 - remainder) * workUnit + 1
        spawn(Worker, :findPerfectSquare, [self(), start, workUnit, k])
      end
    end

    ### Wait until all actors finished
    waitForWorkers(0, runActors)
  end

  def waitForWorkers(count, noActors) do
    if count < noActors do
      receive do
        :finish -> waitForWorkers(count + 1, noActors)
      end
    end
  end
end

defmodule Worker do
  def sumOfSquares(n) do
    div(n * (n + 1) * (2 * n + 1), 6)
  end

  def checkSumToSquare(first, k) do
    sum = sumOfSquares(first + k - 1) - sumOfSquares(first - 1)

    rootTrunc = trunc(:math.sqrt(sum))
    rootTrunc * rootTrunc == sum
  end

  def findPerfectSquare(boss, start, workUnit, k) do
    for i <- start..(start + workUnit - 1) do
      if checkSumToSquare(i, k) do
        IO.inspect(i)
      end
    end

    send(boss, :finish)
  end
end
