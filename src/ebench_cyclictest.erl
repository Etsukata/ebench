-module(ebench_cyclictest).
-compile([debug_info]).
-export([start/4, timer_loop/6]).

start(I, L, N, P) ->
    io:format("Interval: ~p, Loops: ~p, Processes: ~p, Priority: ~p~n",
              [I, L, N, P]),
    register(timer_root, self()),
    spawn_timer(I, L, N, P),
    wait_timer(N),
    unregister(timer_root),
    ok.

spawn_timer(_I, _L, 0, _P) -> ok;
spawn_timer(I, L, N, P) ->
    spawn_opt(?MODULE, timer_loop, [I, L, N, undef, 0, 0], [{priority, P}]),
    spawn_timer(I, L, N - 1, P).

timer_loop(_I, 0, _N, MIN, AVG, MAX) ->
    io:format("Pid: ~p, Min: ~p, Avg: ~p, Max: ~p~n",
              [self(), MIN, AVG, MAX]),
    timer_root ! done,
    ok;
timer_loop(I, L, N, MIN, AVG, MAX) ->
    Start = erlang:now(),
    timer:sleep(I),
    End = erlang:now(),
    Diff = timer:now_diff(End, Start) - I * 1000,
    NMIN = min(Diff, MIN),
    NAVG = avg(Diff, AVG, L),
    NMAX = max(Diff, MAX),
    timer_loop(I, L - 1, N, NMIN, NAVG, NMAX).

avg(Diff, AVG, L) ->
    trunc(((L - 1)  * AVG + Diff) / L).

wait_timer(0) -> ok;
wait_timer(N) ->
    receive
        done ->
            wait_timer(N-1)
    end.
