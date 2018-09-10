# Student info
* Name: Truc D Nguyen
* UFID: 9482-7764

# Instructions
### Compilation
```
mix compile
```

### Run syntax
```
mix run proj1.exs <n> <k>
```
- n: input _N_
- k: input _k_

### Output 
On each line is the first number in the sequence for each solution.

### Example
```
$ mix run proj1.exs 40 24
1
9
20
25
```

# Assigning work unit
To calculate the sum of squares of a sequence 1..N, I use the following equation:
```
SUM(N) = N(N+1)(2N+1)/6
```
Therefore, for a sequence of _k_ elements starting from _i_, the sum of squares will be:
```
SUM(i + k - 1) - SUM(i - 1)
```
That means each sequence only takes O(1).

Denoting _c_ as the number of workers, each one will be given a work unit of **(n/c)** sequence(s).  
In case _n_ is not divisible by _c_, the first **(n%c)** workers will be given 1 more sequence.