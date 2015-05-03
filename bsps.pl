prim_fluent(wolf_pos).
prim_fluent(sheep_pos).
prim_fluent(cabbage_pos).
prim_fluent(guy_pos).

initially(wolf_pos, a).
initially(sheep_pos, a).
initially(cabbage_pos, a).
initially(guy_pos, a).

prim_action(takeWolf_toA).
prim_action(takeWolf_toB).
prim_action(takeSheep_toA).
prim_action(takeSheep_toB).
prim_action(takeCabbage_toA).
prim_action(takeCabbage_toB).
prim_action(guyTakes_toA).
prim_action(guyTakes_toB).

poss(takeWolf_toA, and(wolf_pos = b, guy_pos = b)).
poss(takeWolf_toB, and(wolf_pos = a, guy_pos = a)).
poss(takeSheep_toA, and(sheep_pos = b, guy_pos = b)).
poss(takeSheep_toB, and(sheep_pos = a, guy_pos = a)).
poss(takeCabbage_toA, and(cabbage_pos = b, guy_pos = b)).
poss(takeCabbage_toB, and(cabbage_pos = a, guy_pos = a)).
poss(guyTakes_toA, guy_pos = b).
poss(guyTakes_toB, guy_pos = a).

causes_val(takeWolf_toA, wolf_pos, a, true).
causes_val(takeWolf_toB, wolf_pos, b, true).
causes_val(takeSheep_toA, sheep_pos, a, true).
causes_val(takeSheep_toB, sheep_pos, b, true).
causes_val(takeCabbage_toA, cabbage_pos, a, true).
causes_val(takeCabbage_toB, cabbage_pos, b, true).
causes_val(guyTakes_toA, guy_pos, a, true).
causes_val(guyTakes_toB, guy_pos, b, true).

execute(A, Sr) :- ask_execute(A, Sr).

senses(_, _) :- fail.
exog_occurs(_Act) :- fail.

proc(safeState, and(
	or(neg(sheep_pos = wolf_pos), guy_pos = sheep_pos),
	or(neg(cabbage_pos = sheep_pos), guy_pos = cabbage_pos))).

proc(move, [
	ndet(
		ndet(
			ndet(
				[takeWolf_toA | guyTakes_toA], 
				[takeWolf_toB | guyTakes_toB]),
			ndet(
				[takeSheep_toA | guyTakes_toA], 
				[takeSheep_toB | guyTakes_toB])), 
		ndet(
			ndet(
				[takeCabbage_toA | guyTakes_toA],
				[takeCabbage_toB | guyTakes_toB]),
			ndet(
				guyTakes_toA,
				guyTakes_toB)))]).

proc(solveFor(N), ndet(
	?(and(and(wolf_pos = b, sheep_pos = b), cabbage_pos = b)),
	[?(N > 0),
	move, ?(safeState),
	pi(m, [?(m is N - 1) , solveFor(m)])])).

proc(solveMin(N), ndet(
	solveFor(N),
	pi(m, [?(m is N + 1), solveMin(m)]))).

proc(smartSearch, search(solveMin(0))).
