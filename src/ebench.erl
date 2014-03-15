%%
%% @author Eiichi Tsukata <devel@etsukata.com>
%% @doc ebench - Erlang Benchmark Suite
%% @copyright 2014 Eiichi Tsukata
%%


-module(ebench).
-compile([debug_info]).
-export([start/0, ring/2, ping_pong/1]).

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

