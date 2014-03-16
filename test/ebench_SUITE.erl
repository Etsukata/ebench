-module(ebench_SUITE).
-include_lib("common_test/include/ct.hrl").
-export([all/0, groups/0]).
-export([ringN100M100/1, ringN200M200/1, ringN400M400/1, ringN800M800/1,
         ping_pongN10k/1, ping_pongN40k/1,
         ping_pongN160k/1, ping_pongN640k/1,
         hackbenchG5N5L100/1, hackbenchG10N10L100/1,
         hackbenchG20N20L100/1, hackbenchG40N40L100/1]).

all() -> [{group, ring},
          {group, ping_pong},
          {group, hackbench}].

groups() -> [{ring,
              [],
              [ringN100M100, ringN200M200, ringN400M400, ringN800M800]},
             {ping_pong,
              [],
              [ping_pongN10k, ping_pongN40k,
               ping_pongN160k, ping_pongN640k]},
             {hackbench,
              [],
              [hackbenchG5N5L100, hackbenchG10N10L100,
               hackbenchG20N20L100, hackbenchG40N40L100]}].


ringN100M100(_Config) ->
    ok = ebench:ring(100, 100).

ringN200M200(_Config) ->
    ok = ebench:ring(200, 200).

ringN400M400(_Config) ->
    ok = ebench:ring(400, 400).

ringN800M800(_Config) ->
    ok = ebench:ring(800, 800).

ping_pongN10k(_Config) ->
    ok = ebench:ping_pong(10000).

ping_pongN40k(_Config) ->
    ok = ebench:ping_pong(40000).

ping_pongN160k(_Config) ->
    ok = ebench:ping_pong(160000).

ping_pongN640k(_Config) ->
    ok = ebench:ping_pong(640000).

hackbenchG5N5L100(_Config) ->
    ok = ebench:hackbench(5, 5, 100).

hackbenchG10N10L100(_Config) ->
    ok = ebench:hackbench(10, 10, 100).

hackbenchG20N20L100(_Config) ->
    ok = ebench:hackbench(20, 20, 100).

hackbenchG40N40L100(_Config) ->
    ok = ebench:hackbench(40, 40, 100).

