%% -*- erlang-indent-level: 4;indent-tabs-mode: nil -*-
%% ex: ts=4 sw=4 et
%% @author Kevin Smith <kevin@opscode.com>
%% @copyright 2011 Opscode, Inc.

-module(worker).

-behaviour(gen_server).

-export([start_link/0, start/0]).

%% gen_server callbacks
-export([init/1,
         handle_call/3,
         handle_cast/2,
         handle_info/2,
         terminate/2,
         code_change/3]).

-record(state, {}).

start_link() ->
    io:format("worker start_link!\n", []),
    gen_server:start_link(?MODULE, [], []).

start() ->
    io:format("New worker running in proc ~p!\n", [self()]),
    {ok, NewPid}    = supervisor:start_child(worker_sup, []),
    %{ok, ChildPid}  = supervisor:start_child(worker_sup, []),
    io:format("New worker with PiD ~p!\n", [NewPid]).

init(_Args) ->
    %[Num] = Args,
    io:format("Is this blocking?!\n", []),
    %timer:sleep(3000),
    io:format("Done?!\n", []),
    %[{name, Name}, {age, Age}] = Details,
    %[{name, Name}, {age, Age}] = [{name, "H=dog"}, {age, 22}],
    %io:format("A child is born and it's name is ~s, magically he was born ~n years old\n", {Name, Age}),
    %io:format("Kid is 1!\n", []),
    %timer:sleep(2000),
    %io:format("Kid is 2!\n", []),
    %timer:sleep(2000),
    %io:format("They grow up so fast!\n", []),
    {ok, self()}.

handle_call(_Request, _From, State) ->
    {reply, ignored, State}.

handle_cast({timeTest, Name}, State) ->
    io:format("~p They grow up so fast!\n", [Name]),
    timer:sleep(1500),
    io:format("Adolescence! ~p\n", [Name]),
    timer:sleep(1500),
    io:format("Adulthood! ~p\n", [Name]),
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