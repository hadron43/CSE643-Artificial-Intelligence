% Author: Harsh Kumar
% Roll Number: 2019043

% DFS pseudo code algorithm pseudocode

/*
1. Init lists OPEN  {Si}, CLOSED  {}
2. if OPEN = {}
	then return FAIL
3. Remove first node S from OPEN and insert it into CLOSED
4. Expand node S
	4.1. Generate all successors Sj of node S
	4.2. for each succesor Sj of S do
		4.2.1. Set link Sj → S
		4.2.2. if Sj is final state then
			i. Solution is (Sj, .., Si)
			ii. return SUCCESS
		4.2.3. Insert Sj in OPEN, at the beginning
5. repeat from 2
end.
*/

/*	predicate to begin the dfs search*/

start_dfs():-
	write("Depth First Search:-"), nl ,
	write("Source\t:"), read(S), nl ,
	write("Destination\t:"), read(D), nl ,
	dfs(S, D, [S], 0).

/*	predicate to do dfs */

dfs(Beg, End, Path, Distance):-
	(
		Beg == End, append(Path, [End], New_Path),
		write("Total Distance: "), write(Distance), nl,
		write("Path: "), write(New_Path),
		dfs()
	);
	(
		distance(Beg, End, V),
		X is Distance + V,
		dfs(End, End, Path, X)
	);
	(
		distance(Beg, Next, Val),
		not(Val= -),
		\+member(Next, Path),
		X is Distance+Val,
		append(Path, [Next], New_Path),
		dfs(Next, End, New_Path, X)
	).

dfs().

% Test for dfs search
% Tests the above dfs function by creating a graph

test():-
	dummy_fact(), start_dfs().


dummy_fact():-
	assert(distance('a', 'b', 5)),
	assert(distance('b', 'c', 2)),
	assert(distance('c', 'd', 1)),
	assert(distance('a', 'd', 5)).
