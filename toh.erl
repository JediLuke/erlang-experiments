%%% Towers of Hanoi - iterative solution
%%% Author - Luke Taylor

-module(toh).
-compile(export_all).

main() ->
	io:format("Towers of Hanoi~n"),
	T1 = [6, 5, 4, 3, 2, 1], % Larger number = wider disk
	T2 = [],
	T3 = [],
	
	%% Iterative loop
	ok.





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Internal Functions


%%% This function prints the status of the three towers to the terminal
print_towers(T1, T2, T2) ->
	Height = max_height(T1, T2, T3),
	print_towers(T1, T2, T3, Height).
print_towers(_T1, _T2, _T3, 0) ->
	ok;
print_towers(T1, T2, T3, Height) when Height >= 0 ->
	D1 = disk_size(T1, Height),
	D2 = disk_size(T2, Height),
	D3 = disk_size(T3, Height),
	io:format("~p I ~p   ~p I ~p   ~p I ~p~n", [D1, D1, D2, D2, D3, D3]),
	print_towers(T1, T2, T3, Height-1).
	

%%% Returns the maximum of three towers
max_height(N1, N2, N3) ->
	max(max(length(N1), length(N2)), length(N3)).
% max(X, Y) when X >= Y -> X;
% max(X, Y) when Y > X -> Y.


%%% Gets the size of a disk, after checking that the disk isn't empty at that height
disk_size(D, Height) when length(D) < Height ->
	D2 = [ ], %% Size is zero,
	D2;
disk_size(D, Height) when length(D) >= Height ->
	half_disk(lists:nth(Height, D)). %% Get size of the disk at 'Height' of disk 'D'


%%% Returns a string of '%' which is Num characters
half_disk(Num) when Num >= 0 ->
	half_disk("", Num).
half_disk(Str, 0) ->
	Str;
half_disk(Str, Num) when Num > 0 ->
	"%" ++ half_disk(Str, Num-1).


%%% This function drops the last element from a list
drop_last([]) ->
	ok;
drop_last(List) ->
	%% Remove last element in list
	lists:reverse(tl(lists:reverse(List))).