-module(funcs).

run_async_no_supervisor(Module, Data) ->
    {ok, Pid} = gen_server:start_link(Module, [], []),
    gen_server:call(Pid, Data).