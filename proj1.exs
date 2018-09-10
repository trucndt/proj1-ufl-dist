noActors = 8 # desired number of actors

# Parse command line input
[n, k] = Enum.map(System.argv(), fn x -> String.to_integer(x)  end)

# Start program
Proj1.startBoss(n, k, noActors)


### BONUS: run on 2 machine => Uncomment the following lines and comment the previous line
#Node.start(:"m1@127.0.0.1") # :"name@host" of this machine running the code
#Node.set_cookie(:truc)
#node2 = :"m2@10.227.162.233" # :"name@host" of the remote machine
#Proj1.startBoss(n, k, noActors, node2)