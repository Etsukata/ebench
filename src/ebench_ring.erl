-module(ebench_ring).
-compile([debug_info]).
-export([start/2, spawn_next/2]).

start(N, M) ->
    io:format("Ring with ~p processes which pass token ~p times.~n", [N, M]),
    Next = spawn(?MODULE, spawn_next, [N, self()]),
    receive_token(Next, M).

receive_token(Next, 0) ->
    %% receive the last token
    receive
        pass -> ok
    end,
    Next ! kill,
    io:format("End.~n");
receive_token(Next, M) ->
    receive
        ok ->
            io:format("Start passing token.~n"),
            Next ! pass,
            receive_token(Next, M);
        pass ->
            io:format("Token received.~n"),
            Next ! pass,
            receive_token(Next, M-1)
    end.

spawn_next(1, Root) ->
    Root ! ok,
    pass_through(Root);
spawn_next(N, Root) ->
    Next = spawn(?MODULE, spawn_next, [N-1, Root]),
    pass_through(Next).

pass_through(Next) ->
    receive
        pass ->
            Next ! pass,
            pass_through(Next);
        kill ->
            Next ! kill
    end.
