-module(conc_sup).
-behaviour(supervisor).

-export([start_link/0]).
-export([init/1]).


-define(SERVER, ?MODULE).

start_link() ->
    supervisor:start_link({local, ?SERVER}, ?MODULE, []).
    %%supervisor:start_link(test_sup, []).

init(_Args) ->
	RestartStrategy = one_for_one,
	MaxRestart      = 0,
	MaxTime         = 1,

	ChildSpecs = [{proc_spawner, {proc_spawner, start_link, []}, permanent, 5000, worker,     [proc_spawner]}, 
				  {worker_sup,   {worker_sup,   start_link, []}, permanent, 5000, supervisor, [worker_sup]}],

    {ok, { {RestartStrategy, MaxRestart, MaxTime}, ChildSpecs} }.