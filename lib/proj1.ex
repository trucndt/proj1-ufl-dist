defmodule Proj1 do
  def startBoss(n, k, noActors) do
    workUnit = div(n, noActors)
    remainder = rem(n, noActors)
    runActors = if (workUnit == 0), do: remainder, else: noActors

    ### Calculate and assisn work units to each actor
    for i <- 1..runActors do
      start = findStartIndex(i, remainder, workUnit)

      if i <= remainder do
        spawn(Worker, :findPerfectSquare, [self(), start, workUnit + 1, k])
      else
        spawn(Worker, :findPerfectSquare, [self(), start, workUnit, k])
      end
    end

    ### Wait until all actors finished
    waitForWorkers(0, runActors)
  end

  def findStartIndex(proc, remainder, workUnit) do
    if proc <= remainder + 1 do
      (proc - 1) * (workUnit + 1) + 1
    else
      remainder * (workUnit + 1) + (proc - 1 - remainder) * workUnit + 1
    end
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
    n * (n + 1) * (2 * n + 1) / 6
  end

  def checkSumToSquare(first, k) do
    sum = sumOfSquares(first + k - 1) - sumOfSquares(first - 1)

    rootTrunc = trunc(:math.sqrt(sum))
    rootTrunc * rootTrunc == sum
  end

  def findPerfectSquare(boss, start, workUnit, k) do
    for i <- start..start + workUnit - 1 do
      if checkSumToSquare(i, k) do
        IO.inspect(i)
      end
    end

    send(boss, :finish)
  end
end
