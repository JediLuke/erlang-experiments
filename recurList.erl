-module(recurList).
-export([countdownList/1, isProperList/1, isProperList2/1]).


%% This module is a test module to aid my learning of Erlang. It's called recurList
%% because the first problem I tackled was writing a function to test if a list
%% is a proper list (last element is an empty list - '[]' ).


countdownList(0) -> [];
countdownList(N) when N > 0 -> [ N | countdownList(N-1) ].

%% Test that last element in list is a [] and therefore that this is a proper list
isProperList([]) -> true;
isProperList(X) when is_list(X) ->
	case X of
		[_|[]] 							-> true;
		[_|Tail] when is_list(Tail) 	-> isProperList(Tail)
		%% NOTE: This function raises a 'no case caluse matching error' when 
		%% passed in a list were the tail is not a list, i.e. not a proper list! e.g. [p|0]
	end;
isProperList(_) -> false.

%% Different algorithm for testing if something is a proper list, simply recurses a list
%% until it gets to an element which is not a list and tests it.
isProperList2([_|T]) -> isProperList2(T);
isProperList2(Tail) ->
	case Tail of
		[]  -> true;
		_   -> false
	end.