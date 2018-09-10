defmodule Proj1 do
  @moduledoc """
    Execution of the boss
  """

  @doc """
    Starting point of the program
    @param n  input n
    @param k  input k
    @param noActors desired number of actors
  """
  def startBoss(n, k, noActors) do
    runActors = workAssignment(n, k, noActors)

    ### Wait until all actors finished
    waitForWorkers(runActors)
  end

  @doc """
    Assign work unit to each actor
    @param n  input n
    @param k  input k
    @param noActors desired number of actors
    @return actual number of actors spawn
  """
  def workAssignment(n, k, noActors) do
    # Calculate expected amount of work
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

    runActors
  end

  @doc """
    Wait until other actors finish
    @param noActos  number of running actors
  """
  def waitForWorkers(noActors) do
    if noActors > 0 do
      receive do
        :finish -> waitForWorkers(noActors - 1)
      end
    end
  end
end

defmodule Worker do
  @moduledoc """
    Worker actor handler
  """

  @doc """
    Sum of squares from 1 to N, sum = n(n+1)(2n+1)/6
    @param n  the number N
    @return sum
  """
  def sumOfSquares(n) do
    div(n * (n + 1) * (2 * n + 1), 6)
  end

  @doc """
    Check if the list from <first> with k elements sum to a perfect square
    @param first  the first number of the list
    @param k  number of elements
    @return true if sum to a perfect squares, false otherwise
  """
  def checkSumToSquare(first, k) do
    sum = sumOfSquares(first + k - 1) - sumOfSquares(first - 1)

    ### Check if <sum> is a perfect square
    rootTrunc = trunc(:math.sqrt(sum))
    rootTrunc * rootTrunc == sum
  end

  @doc """
    Start of worker actor
    @param boss pid of the caller
    @param start  the start point of work unit
    @param workUnit amount of work unit
    @param k  input k
  """
  def findPerfectSquare(boss, start, workUnit, k) do
    for i <- start..(start + workUnit - 1) do
      if checkSumToSquare(i, k) do
        IO.inspect(i)
      end
    end
    # Signal finish
    send(boss, :finish)
  end
end
