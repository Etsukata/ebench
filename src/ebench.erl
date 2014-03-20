%%
%% @author Eiichi Tsukata <devel@etsukata.com>
%% @doc ebench - Erlang Benchmark Suite
%% @copyright 2014 Eiichi Tsukata
%%

-module(ebench).
-compile([debug_info]).
-export([start/0, ring/2, ping_pong/1, hackbench/3, cyclictest/4]).

%% @doc start
start() ->
    ring(2,3).

-spec ping_pong(N :: integer()) -> ok.
%%
%% @doc Pass messages between two processes N times.
%%
ping_pong(N) ->
    ebench_ping_pong:start(N).

-spec ring(N :: integer(), M :: integer()) -> ok.
%%
%% @doc Create N processes in a ring. Send a message round the ring M times.
%% So that a total of N * M messages get sent.
%% This is an excercise in the Erlang book
%% <a href="http://pragprog.com/book/jaerlang/programming-erlang">
%% Programming Erlang</a> writen by Joe Armstrong.
%%
ring(N, M) ->
    ebench_ring:start(N, M).

-spec hackbench(G :: integer(), N :: integer(), L :: integer()) -> ok.
%%
%% @doc Generate G groups of N senders spraying message to N receivers for L
%% times.
%%
%% This benchmark is based on benchmark 'hackbench' by Rusty Russell.
%% Hackbench is a benchmark for scheduler and IPC mechanisms of Linux kernel.
%% Current Linux contains hackbench as one of 'perf bench' benchmarks. See
%% Linux kernel source code 'tools/perf/bench/sched-messaging.c' for more
%% details.
%%
hackbench(G, N, L) ->
    ebench_hackbench:start(G, N, L).

-spec cyclictest(I :: integer(), L :: integer(), N :: integer(),
                 P :: priority_level()) -> ok.
%%
%% @doc Timer resolution test.
%%
%% Cyclictest spawns N processes with priority P and each process repeats
%% 'timer:tc(fun() -> timer:sleep(I) end)' for L times.
%%
%% This benchmark is based on benchmark 'cyclictest' by Thomas Gleixner.
%% Cyclictest is a test for high resolution timer contained in rt-tests
%% benchmark suite. For more details, see <a href="https://rt.wiki.kernel.org/index.php/Main_Page">Real Time Linux Wiki</a>.
%%
cyclictest(I, L, N, P) ->
    ebench_cyclictest:start(I, L, N, P).

