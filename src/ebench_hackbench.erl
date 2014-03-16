-module(ebench_hackbench).
-compile([debug_info]).
-export([start/3, group/3, sender/2, receiver/2]).

start(G, N, L) ->
    io:format("Groups: ~p, Senders: ~p, Loops: ~p~n", [G, N, L]),
    GroupLeaders = spawn_groups(G, N, L, []),
    wait_groups_ready(G),
    group_start(GroupLeaders),
    wait_groups_done(G).

spawn_groups(0, _N, _L, Gs) -> Gs;
spawn_groups(G, N, L, Gs) ->
    GroupLeader = spawn(?MODULE, group, [N, L, self()]),
    spawn_groups(G-1, N, L, [GroupLeader|Gs]).

group(N, L, Root) ->
    Receivers = spawn_receivers(N, L*N, []),
    Senders = spawn_senders(N, L, Receivers, []),
    Root ! ready,
    receive go ->
        sender_start(Senders),
        wait_receivers_done(N),
        Root ! done
    end.

wait_groups_ready(0) -> ok;
wait_groups_ready(G) ->
    receive
        ready ->
            wait_groups_ready(G-1)
    end.

group_start(Gs) -> go_all(Gs).

wait_groups_done(0) ->
    io:format("End~n"),
    ok;
wait_groups_done(G) ->
    receive
        done ->
            wait_groups_done(G-1)
    end.

spawn_receivers(0, _Count, Rs) -> Rs;
spawn_receivers(N, Count, Rs) ->
    R = spawn(?MODULE, receiver, [Count, self()]),
    spawn_receivers(N-1, Count, [R|Rs]).

receiver(0, GL) ->
    GL ! done,
    ok;
receiver(Count, GL) ->
    receive
        message ->
            receiver(Count-1, GL)
    end.

spawn_senders(0, _L, _Rs, Ss) -> Ss;
spawn_senders(N, L, Rs, Ss) ->
    S = spawn(?MODULE, sender, [L, Rs]),
    spawn_senders(N-1, L, Rs, [S|Ss]).

sender(L, Rs) ->
    receive
        go ->
            sender_loop(L, Rs)
    end.

sender_loop(0, _Rs) -> ok;
sender_loop(L, Rs) ->
    send_to_all_receivers(Rs),
    sender_loop(L-1, Rs).

send_to_all_receivers([]) -> ok;
send_to_all_receivers([R|Rs]) ->
    R ! message,
    send_to_all_receivers(Rs).

wait_receivers_done(0) -> ok;
wait_receivers_done(N) ->
    receive
        done ->
            wait_receivers_done(N-1)
    end.

sender_start(Ss) -> go_all(Ss).

go_all([]) -> ok;
go_all([L|Ls]) ->
    L ! go,
    go_all(Ls).

