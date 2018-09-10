# Student info
* Name: Truc D Nguyen
* UFID: 9482-7764

# Instructions
The main source code is in **lib/proj1.ex**
### Configuration and Compilation
To configure the desired number of workers, modify the first line in proj1.exs

To compile:
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

**Example:** with n = 10, we have 10 sequences. Suppose 4 workers are spawn, each worker will be assigned 3, 3, 2, and 2 sequences, respectively.

# Results
When running
```
$ mix run proj1.exs 1000000 4
```
there will be **no** sequences that satisfy the requirement.

### Run time
I use **2** workers for the following problem
```
$ time mix run proj1.exs 1000000 4

real	0m0.409s
user	0m0.689s
sys     0m0.066s
```

- CPU time is 0.689 + 0.066 = 0.755
- REAL time is 0.409
- Ratio CPU/REAL = 1.846

### Large problems
I use **8** workers for the following problems

_100 million_
```
$ time mix run proj1.exs 100000000 20

real	0m8.794s
user	1m7.136s
sys     0m0.056s
```
- CPU time is 67.136 + 0.056 = 67.192
- REAL time is 8.794
- Ratio CPU/REAL = 7.641

_1 billion_
```
$ time mix run proj1.exs 1000000000 20

real	1m36.164s
user	12m8.488s
sys     0m0.066s
```
- CPU time is 728.488 + 0.066 = 728.554
- REAL time is 96.164
- Ratio CPU/REAL = 7.576