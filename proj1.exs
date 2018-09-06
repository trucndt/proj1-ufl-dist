noActors = 8

[n, k] = Enum.map(System.argv(), fn x -> String.to_integer(x)  end)

Proj1.startBoss(n, k, noActors)