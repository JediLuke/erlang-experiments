-module(worker_sup).
-behaviour(supervisor).

-export([start_link/0, start_worker/1]).
-export([init/1]).


-define(SERVER, ?MODULE).

start_link() ->
    supervisor:start_link({local, ?SERVER}, ?MODULE, []).
    %%supervisor:start_link(test_sup, []).

start_worker(Request) ->
    io:format("New worker running in proc ~p! kicked off by supervisor\n", [self()]),
    {ok, NewPid}    = supervisor:start_child(worker_sup, []),
    %{ok, ChildPid}  = supervisor:start_child(worker_sup, []),
    io:format("New worker with PiD ~p!\n", [NewPid]).

init(_Args) ->
    RestartStrategy = simple_one_for_one,
    MaxRestart      = 0,
    MaxTime         = 1,
    
    Esb = {esb, {esb, start_link, []}, temporary, 5000, worker, [esb]},
    ChildSpecs = [Esb],

    {ok, { {RestartStrategy, MaxRestart, MaxTime}, ChildSpecs} }.