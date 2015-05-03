% Basic Action Theory (BAT)
%%%%%%%%%%%%%%%%%%%%%%%%%%%
prim_fluent(test_fluent).

%ACHTUNG: zu jeder primitiven Aktion braucht man ein poss-Prädikat !!!
prim_action(test_action).  
prim_action(write_status(_)).
prim_action(sensing_action).  

exog_action(exog_up).                        
exog_action(exog_down).

senses(sensing_action, test_fluent).

% innere Effekte der Aktionen
causes_val(test_action, test_fluent, T, T is test_fluent + 1). % hier werden die Bedingugnen verwendet, um Werte zu berechnen
causes_val(exog_up, test_fluent, T, T is test_fluent + 1). 
causes_val(exog_down, test_fluent, T, T is test_fluent - 1). 

% Vorbedingungen der primitven Aktionen
poss(test_action, test_fluent =< 2). 
poss(write_status(_), true).   % write_status ist immer möglich
poss(sensing_action, test_fluent > 2).   

% äußere Effekte der primitiven Aktionen
execute(test_action, _No_sensing) :-
    write('Execute test_action.'), nl.
execute(write_status(S), _No_sensing) :-
    write('Status: '), write(S), nl.
execute(sensing_action, S) :-
    write('Give a sensing result (an integer); terminate with "." and Enter: '), read(S).

% abfragen der exogenen Aktionen
exog_occurs(_Act) :- fail. % wenn man keine exogenen Aktionen hat, kommt diese Zeile zum tragen

% Wenn man die folgenden drei Zeilen auskommentiet, wird nur die main-Prozedur ausgeführt.
% Sonst wird immer nach der exogenen Aktion gefragt, die als nächstes ausgeführt werden soll.
% Wenn man keine exogenen Aktion angibt, läuft die main-Prozedur einen Schritt weiter, bis wieder nach einer exogenen Aktion gefragt wird.
exog_occurs(Act) :-     % sollange man "exog_up." oder "exog_down." eingibt, wird diese Prozedur aufgerufen
    write('Write "exog_up.", "exog_down." or "none." and press Enter: '),
    read(Act).
    
% initialer Zustand
initially(test_fluent, 0). % bei diesem Interpreter können Fluenten Prädikate sein (mit true oder false) oder Funktionen (mit Zahlen oder logischen Konstanten)

% Golog-Programm
%%%%%%%%%%%%%%%%
proc(main, [
        while( and(test_fluent >= 0, test_fluent < 10), [
            ndet(sensing_action, test_action), 
            pi(v_status, [ % v_status ist eine Golog-Variable
                ?(v_status is test_fluent),   % setze v_status auf den Wert des Fluenten
                write_status(v_status)        % man kann hier leider nicht call-by-name mit dem Fluenten direkt anwenden
            ])
        ])
]).
                 
