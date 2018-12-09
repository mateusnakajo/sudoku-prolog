:- use_module(library(clpfd)).

sudoku(Linhas) :-
        % A configuração Sudoku é valida se ela satisfizer cada predicado 
        % definido abaixo.
        tabuleiro(Linhas),
        linhas(Linhas),
        colunas(Linhas),
        blocos(Linhas).

% Define que o tabuleiro é composto por 9 colunas com 9 elementos,
% e cada elemento é um inteiro de 1 a 9.
tabuleiro(Linhas) :-
        length(Linhas, 9), %é composto por 9 linhas
        maplist(same_length(Linhas), Linhas), %todas de mesmo comprimento
        append(Linhas, Vs), Vs ins 1..9. %transforma a matriz em uma lista e verifica se é formada por números de 1 a 9.

% Define que todos os elementos de cada linha são distintos
linhas(Linhas) :-
        maplist(all_distinct, Linhas).

% Define que todos os elementos de cada coluna são distintos
colunas(Linhas) :-
        transpose(Linhas, Colunas), %transpõe a matriz (colunas viram linhas)
        linhas(Colunas).

% Define que todos os elementos de cada bloco são distintos
blocos(Linhas) :-
        Linhas  = [A, B, C, D, E, F, G, H, I],
        blocos(A, B, C),
        blocos(D, E, F),
        blocos(G, H, I).

% Recebe três linhas, e verifica se os 3 blocos são formados por elementos distintos.
blocos([], [], []). %base da recursão
blocos([N1,N2,N3|Ns1], [N4,N5,N6|Ns2], [N7,N8,N9|Ns3]) :- %separa os 3 primeiros de cada linha
        all_distinct([N1,N2,N3,N4,N5,N6,N7,N8,N9]),
        blocos(Ns1, Ns2, Ns3). %chamada recursiva para o resto (linha - 3 primeiros)

%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%Testes%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%

%problemas retirados de:
%http://www.extremesudoku.info/sudoku.html
%ordem decrescente de dificuldade segundo o site
problema(1, P) :-
        P = [[3,7,_,_,1,_,_,5,8],
             [6,1,_,_,_,_,_,7,2],
             [_,_,2,_,_,_,1,_,_],
             [_,_,_,6,_,8,_,_,_],
             [7,_,_,_,4,_,_,_,5],
             [_,_,_,7,_,3,_,_,_],
             [_,_,7,_,_,_,5,_,_],
             [2,6,_,_,_,_,_,4,3],
             [1,8,_,_,3,_,_,2,9]].

problema(2, P) :-
        P = [[5,9,_,_,6,_,_,7,1],
             [1,6,_,_,_,_,_,3,9],
             [_,_,7,_,_,_,4,_,_],
             [_,_,_,5,_,2,_,_,_],
             [7,_,_,_,8,_,_,_,2],
             [_,_,_,9,_,4,_,_,_],
             [_,_,5,_,_,_,9,_,_],
             [9,3,_,_,_,_,_,5,7],
             [4,7,_,_,9,_,_,8,3]].

problema(3, P) :-
        P = [[8,_,1,_,_,2,9,_,6],
             [_,4,_,_,5,_,_,2,_],
             [_,_,_,_,_,_,_,_,_],
             [_,_,9,_,_,_,_,_,1],
             [_,2,_,_,7,_,_,4,_],
             [5,_,_,_,_,_,8,_,_],
             [_,_,_,_,_,_,_,_,_],
             [_,6,_,_,3,_,_,5,_],
             [4,_,7,5,_,_,1,_,9]].

problema(4, P) :-
        P = [[9,_,_,_,_,_,_,_,5],
             [_,_,3,2,_,9,7,_,_],
             [_,2,_,_,7,_,_,8,_],
             [_,9,_,_,5,_,_,7,_],
             [_,_,2,7,_,6,4,_,_],
             [_,6,_,_,2,_,_,9,_],
             [_,8,_,_,6,_,_,3,_],
             [_,_,7,9,_,3,1,_,_],
             [3,_,_,_,_,_,_,_,7]].

problema(5, P) :-
        P = [[8,_,1,_,3,_,7,_,_],
             [_,6,_,_,1,_,_,8,_],
             [7,_,_,_,_,2,_,_,3],
             [_,_,_,5,_,_,9,_,_],
             [9,4,_,_,8,_,_,6,5],
             [_,_,6,_,_,9,_,_,_],
             [4,_,_,3,_,_,_,_,1],
             [_,3,_,_,7,_,_,9,_],
             [_,_,7,_,5,_,8,_,4]].

%uma solução do sudoku
solucao(1, P) :- 
        P = [[1, 2, 3, 4, 5, 6, 7, 8, 9],
             [4, 5, 6, 7, 8, 9, 1, 2, 3],
             [7, 8, 9, 1, 2, 3, 4, 5, 6],
             [2, 1, 4, 3, 6, 5, 8, 9, 7],
             [3, 6, 5, 8, 9, 7, 2, 1, 4],
             [8, 9, 7, 2, 1, 4, 3, 6, 5],
             [5, 3, 1, 6, 4, 2, 9, 7, 8],
             [6, 4, 2, 9, 7, 8, 5, 3, 1],
             [9, 7, 8, 5, 3, 1, 6, 4, 2]].

%configuração inválida para sudoku
solucao_errada(1, P) :- 
        P = [[2, 2, 3, 4, 5, 6, 7, 8, 9],
             [4, 5, 6, 7, 8, 9, 1, 2, 3],
             [7, 8, 9, 1, 2, 3, 4, 5, 6],
             [2, 1, 4, 3, 6, 5, 8, 9, 7],
             [3, 6, 5, 8, 9, 7, 2, 1, 4],
             [8, 9, 7, 2, 1, 4, 3, 6, 5],
             [5, 3, 1, 6, 4, 2, 9, 7, 8],
             [6, 4, 2, 9, 7, 8, 5, 3, 1],
             [9, 7, 8, 5, 3, 1, 6, 4, 2]].
