ebench
======

Erlang Benchmark Suite

Benchmarks
----------

 * ring : Create processes in a ring. Send a message round the ring.
 * ping_pong : Pass messages between two processes.
 * hackbench : Generate groups of senders spraying message to receivers.

Usage
-----

        # make
        # erl -pa ebin
        > ebench:ring(2,3).


Documentation
-------------

See `edoc` document for more details.

        # make edoc
        # firefox doc/index.html

