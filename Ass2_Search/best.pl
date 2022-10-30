% Author: Harsh Kumar
% Roll Number: 2019043

% Best First Search algorithm pseudocode

/*
1. Init lists OPEN = {Si}, CLOSED = {}
2. if OPEN = {}
		then return FAIL
3. Sort nodes in OPEN with the minimum estimated
	cost one to goal first
4. Remove first node S from OPEN and insert it in CLOSED
5. Expand node S
	5.1. Generate all direct successors Sj of node S
	5.2. for each successor Sj of S do
	5.2.1. Make link Sj → S
	5.2.2. if Sj is final state
			then
				i. Solution is (Sj, S, .., Si)
				ii. return SUCCESS

	5.2.3. Insert Sj in OPEN, at the end
6.repeat from 2
end.
*/

start_best_first():-
	write("Best First Search:-"), nl,
	write("Source\t: "), read(S), nl,
	write("Destination\t: "), read(D), nl,
	best_search(S, D, [S], []).


% main predicate that does the best first search

best_search(Beg, End, Open, Close):-
	(
		length(Open, Len), Len == 0, best_search()
	);
	(
		to_list(Open, End, ListOfHeuris),
		sort(3, @=<, ListOfHeuris, Sorted),
		[First  |  _] = Sorted, heuri(Least, _, _) = First,
		remover(Least, Open, NewOpen),
		\+member(Least, Close), append(Close, [Least], Closed),
		insert_open(Beg, Least, End, NewOpen),
		best_search(Beg, End, NewOpen, Closed)
	).

best_search().


% predicate to insert the succesor node in open list and
% check if it contain destination to return directly

insert_open(Beg, L, End, O):-
	(
		(
			distance(L, End, _), assert(parent(End, L)),
			write('Final Path: '), print_path(Beg, End, [], 0)
		);
		(
			distance(L, Next, _), \+ member(Next, O), append(O, [Next], New_O),
			insert_open(Beg, L, End, New_O)
		)
	).

% predicate to print the path and total cost

print_path(Start, Last, Path, TotalCost):-
	(
		Last == Start, append(Path, [Last], NewPath),
		write(NewPath), nl,
		write("TotalCost cost: "), write(TotalCost)
	);
	(
		parent(Last, Parent), distance(Last, Parent, V),
		append(Path, [Last], NewPath), Tot is TotalCost + V,
		print_path(Start, Parent, NewPath, Tot)
	).


% predicate to make the list of heuristic facts

to_list([A | B], Dest, [heuri(A, Dest, H) | T]):-
    retract(heuri(A, Dest, H)), to_list(B, Dest, T).

to_list([], _, []).


% predicate to remove an element from list
% (ElementToBeRemoved, InputList, TargetList)

remover(_, [], []).
remover(R, [R | T], T2) :- remover(R, T, T2).
remover(R, [H | T], [H | T2]) :- H \= R, remover(R, T, T2).