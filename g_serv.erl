-module(g_serv).
-behaviour(gen_server).
-define(SERVER, ?MODULE).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% g_serv
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%	INSTRUCTIONS:
%	1) ctrl+h -> Find and replace 'temp_sup' with real module name


-export([start_link/0, stop/0]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2,
	terminate/2, code_change/3]).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% API functions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%	Server interface
%%%	----------------

% DEBUGGED IT: NEED TO MATCH the start_link/Arity's !!!
start_link() ->
	% io:format("Starting with ~p~n",[Params]),
	io:format("gserv start_link~n"),
	%Params = some,
	%% start_link(ServerName, Module, Args, Options) -> Result
	gen_server:start_link({local, ?MODULE}, ?MODULE, [some], []).

stop() ->
	%% Stop server asynchronously
	% io:format("Stopping~n"),
	gen_server:cast(?MODULE, shutdown).


%%% gen_server callbacks
%%%	--------------------


init([Params]) ->
	%Params = none,
    io:format("Initializing with ~p~n", [Params]),
    {ok, initialized}.

handle_call(Message, From, State) ->
	io:format("Generic call handler: '~p' from '~p' while in '~p'~n", [Message, From, State]),
	{reply, ok, State}.
	%% Synchronous, possible return values
	%% {reply, Reply, NewState} 			| {reply, Reply, NewState, Timeout} |
	%% {reply, Reply, NewState, hibernate} 	| {noreply,NewState} 				|
	%% {noreply, NewState, Timeout} 		| {noreply, NewState, hibernate} 	|
	%% {stop, Reason, Reply, NewState} 		| {stop,Reason,NewState}

%%% normal termination clause
handle_cast(shutdown, State) ->
	io:format("Generic cast handler: *shutdown* while in '~p'~n", [State]),
	{stop, by_request, State};
%%%	generic async handler
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