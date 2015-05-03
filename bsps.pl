hello_world :- write('Holla Mudo?').

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
poss(takeSheep_toA, and(sheep_pos = a, guy_pos = a)).
poss(takeSheep_toB, and(sheep_pos = b, guy_pos = b)).
poss(takeCabbage_toA, and(cabbage_pos = a, guy_pos = a)).
poss(takeCabbage_toB, and(cabbage_pos = b, guy_pos = b)).
poss(guyTakes_toA, and(
			and(
				or(
					neg(sheep_pos = wolf_pos),
					sheep_pos = a), 
				or(
					neg(cabbage_pos = sheep_pos),
					cabbage_pos = a)), 
			guy_pos = b)).
poss(guyTakes_toB, and(
			and(
				or(
					neg(sheep_pos = wolf_pos),
					sheep_pos = b), 
				or(
					neg(cabbage_pos = sheep_pos),
					cabbage_pos = b)), 
			guy_pos = a)).

causes_val(takeWolf_toA, wolf_pos, a, true).
causes_val(takeWolf_toB, wolf_pos, b, true).
causes_val(takeSheep_toA, sheep_pos, a, true).
causes_val(takeSheep_toB, sheep_pos, b, true).
causes_val(takeCabbage_toA, cabbage_pos, a, true).
causes_val(takeCabbage_toB, cabbage_pos, b, true).
causes_val(guyTakes_toA, guy_pos, a, true).
causes_val(guyTakes_toB, guy_pos, b, true).

execute(takeWolf_toA, _) :- true.
execute(takeWolf_toB, _) :- true.
execute(take_heep_toA, _) :- true.
execute(take_heep_toB, _) :- true.
execute(takeCabbage_toA, _) :- true.
execute(takeCabbage_toB, _) :- true.
execute(guyTakes_toA, _) :- true.
execute(guyTakes_toB, _) :- true.

exog_occurs(_Act) :- fail.

proc(main, [
	while(or(or(wolf_pos = a, sheep_pos = a), cabbage_pos = a), [
		ndet(
			ndet(
				ndet(
					[takeWolf_toA | guyTakes_toA], 
					[takeWolf_toB | guyTakes_toB]
				),
				ndet(
					[takeSheep_toA | guyTakes_toA], 
					[takeSheep_toB | guyTakes_toB]
				)
			), 
		     	ndet(
				ndet(
					[takeCabbage_toA | guyTakes_toA],
					[takeCabbage_toB | guyTakes_toB]
				),
				ndet(
					guyTakes_toA,
					guyTakes_toB
				)
			)
		),
	])
]).
