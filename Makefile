CC = clang -g
CFLAGS = -g -O2
libs=-lm

flags = -O3 -Wall -Wextra -Weffc++ 
vecflags = -Rpass=loop-vectorize
novecflags = -fno-vectorize

all : runvec runnovec

runnovec : tscnovec.o dummy.o
	$(CC) $(noopt) dummy.o tscnovec.o -o runnovec $(libs)

runvec : tscvec.o dummy.o
	$(CC) $(noopt) dummy.o tscvec.o -o runvec $(libs)

tscvec.o : tsc.c
	$(CC) $(flags) $(vecflags) -c -o tscvec.o tsc.c

tscnovec.o : tsc.c
	$(CC) $(flags) $(novecflags) -c -o tscnovec.o tsc.c

tsc.s : tsc.c dummy.o
	$(CC) $(flags) dummy.o tsc.c -S

dummy.o : dummy.c
	$(CC) -c dummy.c

clean :
	rm -f *.o runnovec runvec *.lst *.s

.PHONY: clean
