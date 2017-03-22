%%%-------------------------------------------------------------------
%% @author Luke Taylor
%% @doc polylearn top level supervisor.
%% @end
%%%-------------------------------------------------------------------
-module('polylearn_sup').
-behaviour(supervisor).
-define(SERVER, ?MODULE).

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).


%%====================================================================
%% API functions
%%====================================================================
start_link() ->
    supervisor:start_link({local, ?SERVER}, ?MODULE, []).


%%====================================================================
%% Supervisor callbacks
%%====================================================================
init([]) ->
	% If > MaxR number of restarts occur in the last MaxT seconds
	% the supervisor terminates all the child processes and then itself.
	SupFlags = #{strategy => one_for_one,
				intensity => 1,    % Max restarts
				   period => 5},   % Max timeout

    %% Webserver
	Yaws = #{id => ybed_sup,
		  start => {ybed_sup, start_link, []},
		restart => permanent,
	   shutdown => 5000,
		   type => supervisor,
   	    modules => [ybed_sup]},

	%% Supervisors for components
	Orbito_Sup = #{id => orbito_sup,
				start => {orbito_sup, start_link, []},
		  	  restart => permanent,
	     	 shutdown => 5000,
		     	 type => supervisor,
		  	  modules => [orbito_sup]},

	Thalamus_Sup = #{id => thalamus_sup,
				start => {thalamus_sup, start_link, []},
			  restart => permanent,
			 shutdown => 5000,
				 type => supervisor,
			  modules => [thalamus_sup]},

	Agent_Sup = #{id => agent_sup,
			   start => {agent_sup, start_link, []},
			 restart => permanent,
			shutdown => 5000,
				type => supervisor,
			 modules => [agent_sup]},

   ChildSpecs = [Yaws, Orbito_Sup, Thalamus_Sup, Agent_Sup],
   ok = supervisor:check_childspecs(ChildSpecs),

   {ok, {SupFlags, ChildSpecs}}.


%%====================================================================
%% Internal functions
%%====================================================================
