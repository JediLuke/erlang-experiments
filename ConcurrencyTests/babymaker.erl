-module(babymaker).
-export([make_kid/0, make_kid/2]).

make_kid() ->
	
	io:format("babymaker PID ~p!\n", [self()]),

	%Request = {newWorker, [{name, Name},{ age, Age}]},
    {ok, ChildPid}  = supervisor:start_child(worker_sup, []),
    {ok, ChildPid2} = supervisor:start_child(worker_sup, []),
    {ok, ChildPid3} = supervisor:start_child(worker_sup, []),

    worker:start(),
    worker:start(),
    worker:start(),

    io:format("Now creating some using the supervisor!\n", []),

    worker_sup:start_worker(Request),
    worker_sup:start_worker(Request),
    worker_sup:start_worker(Request),

    io:format("B1 - Kids created!\n", []),

    gen_server:cast(ChildPid,  {timeTest, ChildPid}),
    gen_server:cast(ChildPid2, {timeTest, ChildPid2}),
    gen_server:cast(ChildPid3, {timeTest, ChildPid3}),

    io:format("B1 - Casts sent!\n", []).

make_kid(Name, Age) ->
	%Request = {newWorker, [{name, Name},{ age, Age}]},
	{_One, _Two} = {Name, Age},
    {ok, ChildPid}  = supervisor:start_child(worker_sup, []),
    {ok, ChildPid2} = supervisor:start_child(worker_sup, []),
    {ok, ChildPid3} = supervisor:start_child(worker_sup, []),

    io:format("B1 - Kids created!\n", []),

    gen_server:cast(ChildPid, {timeTest, ChildPid}),
    gen_server:cast(ChildPid2, {timeTest, ChildPid2}),
    gen_server:cast(ChildPid3, {timeTest, ChildPid3}),

    io:format("B1 - Casts sent!\n", []).
    %io:fwrite("1\n"),
	%gen_server:cast(proc_spawner, Request),
	%io:fwrite("2\n"),
	%gen_server:cast(proc_spawner, Request),
	%io:fwrite("3\n"),
	%gen_server:cast(proc_spawner, Request).
	%{ok, PiD} = worker_sup:add_child(),
	%io:fwrite("2\n"),
	%gen_server:cast(PiD, printMe).