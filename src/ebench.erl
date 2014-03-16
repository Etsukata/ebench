%%
%% @author Eiichi Tsukata <devel@etsukata.com>
%% @doc ebench - Erlang Benchmark Suite
%% @copyright 2014 Eiichi Tsukata
%%

-module(ebench).
-compile([debug_info]).
-export([start/0, ring/2, ping_pong/1, hackbench/3]).

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

