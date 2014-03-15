-module(ebench).
-compile([debug_info]).
-export([start/2, ring/2, ping_pong/1]).

start(2,3) ->
    ring(2,3).

ring(N, M) ->
    ebench_ring:start(N, M).

ping_pong(N) ->
    ebench_ping_pong:start(N).

