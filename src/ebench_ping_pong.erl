-module(ebench_ping_pong).
-compile([debug_info]).
-export([start/1]).

start(N) ->
    io:format("Pass ping-pong message between two processes ~p times.~n",
              [N]),
    Pong = spawn(fun() -> pong() end),
    Pong ! {ping, self()},
    ping(N),
    Pong ! kill,
    ok.

ping(0) ->
    receive
        {pong, _Pong} ->
            ok
    end,
    io:format("End.~n");
ping(N) ->
    receive
        {pong, Pong} ->
            Pong ! {ping, self()},
            ping(N-1)
    end.

pong() ->
    receive
        {ping, Ping} ->
            Ping ! {pong, self()},
            pong();
        kill ->
            ok
    end.
