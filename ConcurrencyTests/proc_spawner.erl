%% -*- erlang-indent-level: 4;indent-tabs-mode: nil -*-
%% ex: ts=4 sw=4 et
%% @author Kevin Smith <kevin@opscode.com>
%% @copyright 2011 Opscode, Inc.

-module(proc_spawner).

-behaviour(gen_server).

-export([start_link/0]).

%% gen_server callbacks
-export([init/1,
         handle_call/3,
         handle_cast/2,
         handle_info/2,
         terminate/2,
         code_change/3]).

-record(state, {}).

start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

init(_Args) ->
    {ok, #state{}}.

handle_call(_Request, _From, State) ->
    {reply, ignored, State}.

handle_cast({newWorker, Details}, State) ->
    io:fwrite("Creatine a new worker.\n"),
    [{name, Name}, {age, Age}] = Details,
    io:format("Spawning.... ~p, age..... ~p years old\n", [Name, Age]),
    {ok, ChildPid} = supervisor:start_child(worker_sup, []),
    io:format("PiD.... ~p\n", [ChildPid]),
    {noreply, State};

handle_cast(_Msg, State) ->
    {noreply, State}.

handle_info(_Info, State) ->
    {noreply, State}.

terminate(_Reason, _State) ->
    ok.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

%% Internal functions