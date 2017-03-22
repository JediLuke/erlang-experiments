# Erlang/C interface

See: http://erlang.org/doc/tutorial/overview.html

complex.c is the file with which we wish to interface. It has 2 functions, foo and bar

## NIFs

Uses the following files:

Erlang
------
complex1.erl
C
--
erl_comm.c
port.c

## Running the example

Shell commands
----------------

gcc -o extprg complex.c erl_comm.c port.c (has a WHOLE bunch of compile warnings)



4.3  Running the Example

Step 1. Compile the C code:

unix> gcc -o extprg complex.c erl_comm.c port.c
Step 2. Start Erlang and compile the Erlang code:

unix> erl
Erlang (BEAM) emulator version 4.9.1.2

Eshell V4.9.1.2 (abort with ^G)
1> c(complex1).
{ok,complex1}
Step 3. Run the example:

2> complex1:start("extprg").
<0.34.0>
3> complex1:foo(3).
4
4> complex1:bar(5).
10
5> complex1:stop().
stop