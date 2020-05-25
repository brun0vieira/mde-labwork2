:-consult('base_dados.pl').
:-consult('gestao.pl').
:-consult('consulta.pl').

:-dynamic membro/3. % membro - tipo, nome, localizacao
:-dynamic meio_transporte/4. % meio de transporte - descricao, velocidade (km/h), hora_inicial, hora_final
:-dynamic equipamento/2. % equipamento - descricao, membro pertencente
:-dynamic ligacao/7. % ligacao - origem, destino, distancia, meio de transporte, hora_inicial, hora_final, equipamento a transportar

run:-
    limpar_ecra,
    write('MENU'),nl,nl,
    menu(Opcao),
    menu_principal(Opcao),
    run.

menu(Opcao):-
    write('1. Gestão da base de conhecimento.'),nl,
    write('2. Consultas à base de conhecimento.'),nl,
    write('3. Base de dados.'),nl,
    write('4. Mais informações.'),nl,
    write('5. Sair.'),nl,
    ler_opcao(Opcao, 1, 5).

ler_opcao(Opcao, A, B):-
    nl, write('Opção: '),
    ler_buffer(S),
    atom_number(S, Opcao),
    opcao_valida(Opcao, A, B),nl.

ler_opcao(Opcao, A, B):-
    nl, write('*** Opcao inválida. Tente outra vez: '),
    ler_opcao(Opcao, A, B).

opcao_valida(Opcao, A, B):-

    Opcao >=A,
    Opcao =<B.

menu_principal(1):- menu_gestao.
menu_principal(2):- menu_consulta.
menu_principal(3):- base_dados.
menu_principal(4):- info.
menu_principal(5):- terminar_programa.

menu_gestao:-
    limpar_ecra,
    write('Gestão da base de conhecimento'),nl,nl,
    write('  1. Adicionar membros da rede.'),nl,
    write('  2. Adicionar meios de transporte.'),nl,
    write('  3. Adicionar equipamentos de protecção existentes nos membros.'),nl,
    write('  4. Adicionar ligações entre membros.'),nl,nl,
    write('  5. Alterar meios de transporte.'),nl,
    write('  6. Alterar membros da rede.'),nl,
    write('  7. Alterar equipamentos de protecção existentes nos membros.'),nl,
    write('  8. Alterar ligações entre membros.'),nl,
    write('  9. Alterar ...'),nl,nl,
    write('10. Remover membros da rede.'),nl,
    write('11. Remover equipamentos de protecção existentes nos membros.'),nl,
    write('12. Remover ligações entre membros'),nl,
    write('13. Remover ...'),nl,nl,
    write('14. Voltar ao menu anterior.'),nl,
    ler_opcao(Opcao, 1, 14),
    limpar_ecra,
    gestao(Opcao),
    voltar_menu_anterior,
    menu_gestao.

menu_consulta:-
    limpar_ecra,
    write('Consultas à base de conhecimento'),nl,nl,
    write('  1. Listar membros da rede.'),nl,
    write('  2. Listar equipamentos de protecção existentes.'),nl,
    write('  3. Listar cidades por tipo de membro.'),nl,
    write('  4. Listar transportes e horários disponíveis entre dois membros.'),nl,
    write('  5. Listar itinerários entre membros.'),nl,nl,
    write('  6. Obter itinerário entre membros com menor distancia'),nl,
    write('  7. Obter itinerário entre membros com maior distância.'),nl,
    write('  8. Obter itinerário entre membros com passagem por outros membros.'),nl,
    write('  9. Obter itinerário entre membros passando em membros com determinados equipamentos.'),nl,
    write('10. Obter membros por cidade pretendida.'),nl,
    write('11. Obter a centralidade de um membro.'),nl,nl,
    write('12. Voltar ao menu anterior.'),nl,
    ler_opcao(Opcao, 1, 12),
    limpar_ecra,
    consulta(Opcao),
    voltar_menu_anterior,
    menu_consulta.

base_dados:-
    limpar_ecra,
    write('Operações sobre a base de dados'),nl,nl,
    write('  1. Importar base de dados'),nl,
    write('  2. Eliminar base de dados'),nl,nl,
    write('  3. Voltar ao menu anterior.'),nl,
    ler_opcao(Opcao, 1, 3),
    bd(Opcao),
    voltar_menu_anterior.

info:-
    limpar_ecra,
    write('Projecto nº2 de MDE realizado por:'), nl,
    write('   Bruno Vieira - 50046.'), nl,
    write('   Serafim Ciobanu - 50006.'), nl, nl,
    voltar_menu_anterior.

terminar_programa:- halt.

limpar_ecra:- write('\e[2J').

% Reads text from buffer until 'enter' or 'return' is pressed.
ler_buffer(S) :-readlist1(L), atom_codes(S,L),!.
readlist1(L) :- get_code(C), process1(C,L).
process1(10,[]):-nl.
process1(13,[]):-nl.
process1(C,[C|R]) :- readlist1(R).

%-----------------------------------------------------------
% Gestão da base de conhecimento
%-----------------------------------------------------------

gestao(1):-
    adicionar_membro.
gestao(2):-
    adicionar_transporte.
gestao(3):-
    adicionar_equipamento.
gestao(4):-
    adicionar_ligacao.
gestao(5):-
    alterar_meio_transporte.
gestao(6):-
    alterar_membro.
gestao(7):-
    alterar_equipamento.
gestao(8):-
    alterar_ligacao.
gestao(9):-
    write('por implementar9').
gestao(10):-
    remover_membro.
gestao(11):-
    remover_equipamento.
gestao(12):-
    remover_ligacao.
gestao(13):-
    write('por implementar13').

% Returns to main menu
gestao(14):-
    run.

%-----------------------------------------------------------
% Consulta à base de conhecimentos
%-----------------------------------------------------------

consulta(1):-
    listar_membros.
consulta(2):-
    listar_equipamento.
consulta(3):-
    listar_cidades.
consulta(4):-
    listar_transportes_horarios.
consulta(5):-
    listar_itinerarios_membros.
consulta(6):-
    listar_menor_itinerario.
consulta(7):-
    listar_maior_itinerario.
consulta(8):-
    listar_itinerarios_ponto_intermedio.
consulta(9):-
    listar_itinerarios_equipamento.
consulta(10):-
    obter_membros_cidade.
consulta(11):-
    centralidade_membro.
consulta(12):-
    run.

% Returns to main menu
consulta(10):-
    run.

%-----------------------------------------------------------
% Gerir base de dados
%-----------------------------------------------------------


bd(1):-
    importar_base_dados.
bd(2):-
    eliminar_base_dados.
bd(3):-
    run.

% Aux
opcao_aux(Imprime, Opcoes, Opcao):-
    write(Opcoes),nl,
    write(Imprime),
    ler_buffer(Opcao).


voltar_menu_anterior:-
    write('Pressione \'1\' para voltar ao menu anterior.'), nl,
    ler_opcao(_Opcao, 1, 1).

pretty_display(Lista,Tipo) :- pdisplay(Lista, 0, Tipo).

pdisplay([Lista], N, Tipo):- N1 is N+1, displaymember(N1,Lista, Tipo).
pdisplay([Lista|R], N, Tipo):- N1 is N+1, displaymember(N1,Lista, Tipo),pdisplay(R,N1, Tipo).


displaymember(N,Lista,Tipo):-write(Tipo), write(N), write(': '), dmember(Lista),nl.

dmember([Lista]):-write(Lista).
dmember([Lista|R]):-write(Lista),write('-'),dmember(R).
