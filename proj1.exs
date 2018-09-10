noActors = 8 # desired number of actors

# Parse command line input
[n, k] = Enum.map(System.argv(), fn x -> String.to_integer(x)  end)

# Start program
Proj1.startBoss(n, k, noActors)