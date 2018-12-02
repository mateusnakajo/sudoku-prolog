:- use_module(library(clpfd)).

sudoku(Rows) :-
        board(Rows),
        rows(Rows),
        columns(Rows),
        blocks(Rows).

board(Rows) :-
        length(Rows, 9),
        maplist(same_length(Rows), Rows),
        append(Rows, Vs), Vs ins 1..9.

rows(Rows) :-
        maplist(all_distinct, Rows).

columns(Rows) :-
        transpose(Rows, Columns),
        maplist(all_distinct, Columns).

blocks(Rows) :-
        Rows  = [A, B, C, D, E, F, G, H, I],
        blocks(A, B, C),
        blocks(D, E, F),
        blocks(G, H, I).

blocks([], [], []).
blocks([N1,N2,N3|Ns1], [N4,N5,N6|Ns2], [N7,N8,N9|Ns3]) :-
        all_distinct([N1,N2,N3,N4,N5,N6,N7,N8,N9]),
        blocks(Ns1, Ns2, Ns3).
