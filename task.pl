
% direction = 0 --> boat moves from left to right.
% direction = 1 --> boat moves from right to left.

%direction(0).
%leftSide([3,3]).
%rightSide([0,0]).

:- dynamic leftSide/1.
:- dynamic rightSide/1.
:- dynamic direction/1.

rightt([0, 0]).
leftt([3, 3]).
dd(0).
input([]):-!, false.
input(L):-
	rightt(InitialR),
	leftt(InitialL),
	dd(Dir),
	game(L, Dir, InitialR, InitialL).
	
game([], _, [3, 0], [0, 3]):-!.
game([H|T], Direction, RightSide, LeftSide):-
	move(H, Direction, RightSide, LeftSide),
	isSafe(RightSide, LeftSide),
	(rightSide = [3, 0], leftSide = [0, 3]);
	game(T, direction, rightSide, leftSide).

move([M, C], D, [R1, R2], [L1, L2]):-
	D = 0,
	Tmp is M + C,
	Tmp < 3,
	Tmp > 0,
	(M < L1 ; M = L1),
	(C < L2 ; C = L2),
	R11 is R1 + M,
	R22 is R2 + C,
	L11 is L1 - M,
	L22 is L2 - C,
	updateRS([R11, R22]),
	updateLS([L11, L22]),
	updateDirection(D).
	
move([M, C], D, [R1, R2], [L1, L2]):-
	D = 1,
	Tmp is M + C,
	Tmp < 3,
	Tmp > 0,
	(M < R1 ; M = R1),
	(C < R2 ; C = R2),
	R11 is R1 - M,
	R22 is R2 - C,
	L11 is L1 + M,
	L22 is L2 + C,
	updateRS([R11, R22]),
	updateLS([L11, L22]),
	updateDirection(D).
	
	
isSafe([R1, R2], [L1, L2]):-
	(R1 > R2 ; R1 = R2),
	(L1 > L2 ; L1 = L2).

updateRS(NewRS):-
	retract(rightSide(OldRS)),
	assert(rightSide(NewRS)).

updateLS(NewLS):-
	retract(leftSide(OldLS)),
	assert(leftSide(NewLS)).
	
updateDirection(D):-
	D = 0,
	retract(direction(OldD)),
	assert(direction(1)).

updateDirection(D):-
	D = 1,
	retract(direction(OldD)),
	assert(direction(0)).

