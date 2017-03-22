%%% Higher order functions exercises
%%% Author - Luke Taylor

-module(hof).
-compile(export_all).


%%% Repeated/3
%%% Applied a procedure to it's argumentX,  N times
%%% Usage
%	F = fun(X) -> 2*X end. %% Define some function F, which doubles it's argument
%	% Double 3
%	hof:repeated(F, 3, 1) -> 6
%	% Double 3, twice
%	hof:repeated(F, 3, 2) -> 12
repeated(_Proc, X, 0) ->
	X; %% Finished
repeated(Proc, X, N) when X >= 1 ->
	repeated(Proc, Proc(X), N-1).