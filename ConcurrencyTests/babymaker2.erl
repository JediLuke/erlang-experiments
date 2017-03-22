-module(babymaker2).
-export([make_kid/0, make_kid/2]).

make_kid() ->
	%Request = {newWorker, [{name, Name},{ age, Age}]},
    {ok, ChildPidx}  = supervisor:start_child(worker_sup, []),
    {ok, ChildPid2x} = supervisor:start_child(worker_sup, []),
    {ok, ChildPid3x} = supervisor:start_child(worker_sup, []),

    io:format("B2 - Kids created!\n", []),

    gen_server:cast(ChildPidx,  {timeTest, ChildPidx}),
    gen_server:cast(ChildPid2x, {timeTest, ChildPid2x}),
    gen_server:cast(ChildPid3x, {timeTest, ChildPid3x}),

    io:format("B2 - Casts sent!\n", []).

make_kid(Name, Age) ->
	%Request = {newWorker, [{name, Name},{ age, Age}]},
	{_One, _Two} = {Name, Age},
    {ok, ChildPid}  = supervisor:start_child(worker_sup, []),
    {ok, ChildPid2} = supervisor:start_child(worker_sup, []),
    {ok, ChildPid3} = supervisor:start_child(worker_sup, []),

    io:format("B2 - Kids created!\n", []),

    gen_server:cast(ChildPid, {timeTest, ChildPid}),
    gen_server:cast(ChildPid2, {timeTest, ChildPid2}),
    gen_server:cast(ChildPid3, {timeTest, ChildPid3}),

    io:format("B2 - Casts sent!\n", []).
    %io:fwrite("1\n"),
	%gen_server:cast(proc_spawner, Request),
	%io:fwrite("2\n"),
	%gen_server:cast(proc_spawner, Request),
	%io:fwrite("3\n"),
	%gen_server:cast(proc_spawner, Request).
	%{ok, PiD} = worker_sup:add_child(),
	%io:fwrite("2\n"),
	%gen_server:cast(PiD, printMe).

make_copy_kid() ->
    %Request = {newWorker, [{name, Name},{ age, Age}]},
    {ok, ChildPid}  = supervisor:start_child(worker_sup, []),
    {ok, ChildPid2} = supervisor:start_child(worker_sup, []),
    {ok, ChildPid3} = supervisor:start_child(worker_sup, []),

    io:format("B1 - Kids created!\n", []),

    gen_server:cast(ChildPid, {timeTest, ChildPid}),
    gen_server:cast(ChildPid2, {timeTest, ChildPid2}),
    gen_server:cast(ChildPid3, {timeTest, ChildPid3}),

    io:format("B1 - Casts sent!\n", []).