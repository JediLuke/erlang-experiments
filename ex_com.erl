-module(ex_com).
-behaviour(gen_server).
-define(SERVER, ?MODULE).
-include_lib("eunit/include/eunit.hrl").

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%	@doc
%%% ex_com
%%%	This process loops every LoopTime seconds and sends an update to SkyGrid.
%%%
%%%	@author Luke Taylor
%%%	@end
%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


-define(DEFAULT_LOOPTIME, 10000). % Milliseconds between updates


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% API functions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
-export([start_link/0, stop/0]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2,
	terminate/2, code_change/3]).


%%% 
%%% gen_server interfaces start_link and stop
%%%


start_link() ->
	gen_server:start_link({local, ?MODULE}, ?MODULE, ?DEFAULT_LOOPTIME, []).

stop() ->
	%% Stop server asynchronously
	% io:format("Stopping ~p.~n", [?SERVER]),
	gen_server:cast(?MODULE, shutdown).


%%%
%%% Initialization logic
%%%


init(LoopTime) ->
    io:format("Initializing ~p with ~p.~n", [?SERVER, Params]),
    start_loop(),
    {ok, {msgCount, 0}}.


%%%
%%% Main logic functions
%%%	External facing
%%%


%%% Get the looptime
get_looptime() ->
	gen_server:call(?MODULE, get_looptime_YU234).
handle_call(get_looptime_YU234, From, LoopTime) ->
	{reply, LoopTime, LoopTime}. %% Return the state


%%% Set the looptime
set_looptime(NewTime) ->
	gen_server:cast(?MODULE, {set_looptime_UQXR3, NewTime}).
handle_cast({set_looptime_UQXR3, NewTime}, LoopTime) ->
	{noreply, NewTime}.


%%%
%%% Main logic functions
%%%	Internal use (e.g. looping)
%%%


%%% start the mainloop
handle_cast(mainloop, State) ->
	send_info_msg_to_self(mainloop),
	{noreply, State};


%%% Code that makes up the main loop goes here
handle_info(mainloop, LoopTime) ->
	skygrid_sync(State),
	_TimerRef = erlang:send_after(LoopTime, self(), mainloop),
	{msgCount, OldCount} = State,
	{noreply,
		{msgCount, OldCount + 1}};


%%%
%%% Shutdown logic
%%%


%%% normal termination clause
handle_cast(shutdown, State) ->
	io:format("Generic cast handler: *shutdown* while in '~p'~n", [State]),
	{stop, by_request, State};


%%%
%%% Generic gen_server handlers & functions
%%%


handle_call(Message, From, State) ->
	io:format("Generic call handler: '~p' from '~p' while in '~p'~n", [Message, From, State]),
	{reply, ok, State}.
	%% Synchronous, possible return values
	%% {reply, Reply, NewState} 			| {reply, Reply, NewState, Timeout} |
	%% {reply, Reply, NewState, hibernate} 	| {noreply, NewState} 				|
	%% {noreply, NewState, Timeout} 		| {noreply, NewState, hibernate} 	|
	%% {stop, Reason, Reply, NewState} 		| {stop, Reason, NewState}

handle_cast(Message, State) ->
	io:format("Generic cast handler: '~p' while in '~p'~n", [Message, State]),
	{noreply, State}.
	%% Asynchronous, possible return values
	%% {noreply, NewState} 				| {noreply, NewState, Timeout} |
	%% {noreply, NewState, hibernate} 	| {stop, Reason, NewState}

handle_info(_Message, _State) ->
	io:format("Generic info handler: '~p' '~p'~n", [_Message, _State]),
	{noreply, _State}.
	%% Informative calls - possible return values
	%% {noreply, NewState} 		| {noreply, NewState, Timeout} | {noreply, NewState, hibernate} |
	%% {stop, Reason, NewState} | {stop, Reason, NewState}

terminate(_Reason, _State) ->
	io:format("Generic termination handler: '~p' '~p'~n", [_Reason, _State]),
	ok.

code_change(_OldVersion, State, _Extra) ->
	{ok, State}.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Internal functions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

start_loop() ->
	gen_server:cast(?SERVER, mainloop).

%%%	Updates SkyGrid with all changed parameters since last full sync
skygrid_sync(State) ->

	{ok, SystemState} = diag_mon:request_state(),

	{ok, _UpdateResp} = skygrid:update_excom_state(State),
	{ok, _UpdateResp} = skygrid:update_hw_info(SystemState),

	ok.

send_info_msg_to_self(Msg) ->
	% The very first time we start the loop, it is via a cast.
	% This module is just a wrapper to forward the command onto handle_info
	self() ! Msg.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Unit tests
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


excom_test() ->
	?MODULE = ex_com.

bool_test() ->
	X = 5,
	Y = 5,
	?ASSERT(X =:= Y).