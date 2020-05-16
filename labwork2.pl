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
    write('  4. Adicionar ligações entre membros.'),nl,
    write('  5. Adicionar ...'),nl,nl,
    write('  6. Alterar membros da rede.'),nl,
    write('  7. Alterar equipamentos de protecção existentes nos membros.'),nl,
    write('  8. Alterar ligações entre membros.'),nl,
    write('  9. Alterar ...'),nl,nl,
    write('10. Remover membros da rede.'),nl,
    write('11. Remover de protecção existentes nos membros.'),nl,
    write('12. Remover ligações entre membros'),nl,
    write('13. Remover ...'),nl,
    write('14. Voltar ao menu anterior.'),nl,
    ler_opcao(Opcao, 1, 14),
    gestao(Opcao),
    menu_gestao.

menu_consulta:-
    limpar_ecra,
    write('Consultas à base de conhecimento'),nl,nl,
    write('  1. Listar membros da rede.'),nl,
    write('  2. Listar equipamentos de protecção existentes.'),nl,
    write('  3. Listar cidades por equipamento existente.'),nl,
    write('  4. Listar itinerários entre membros.'),nl,
    write('  5. Obter itinerário entre membros com menor distancia'),nl,
    write('  6. Obter itinerário entre membros com maior distância.'),nl,
    write('  8. Obter itinerário entre membros com passagem por outros membros.'),nl,
    write('  9. Obter ...'),nl,
    write('10. Voltar ao menu anterior.'),nl,
    ler_opcao(Opcao, 1, 10),
    consulta(Opcao),
    menu_consulta.

base_dados:-
    limpar_ecra,
    write('Operações sobre a base de dados'),nl,nl,
    write('  1. Importar base de dados'),nl,
    write('  2. Eliminar base de dados'),nl,
    write('  3. Voltar ao menu anterior.'),nl,
    ler_opcao(Opcao, 1, 3),
    bd(Opcao),
    base_dados.

info:-
    limpar_ecra,
    write('Projecto nº2 de MDE realizado por:'), nl,
    write('   Bruno Vieira - 50046.'), nl,
    write('   Serafim Ciobanu - 50006.'), nl, nl,
    write('Pressione \'1\' para voltar ao menu principal.'), nl,
    ler_opcao(_Opcao, 1, 1).

terminar_programa:- halt.

limpar_ecra:- write('\e[2J').

% Reads text from buffer until 'enter' or 'return' is pressed.
ler_buffer(S) :-readlist1(L), atom_codes(S,L),!.
readlist1(L) :- get_code(C), process1(C,L).
process1(10,[]):-nl.
process1(13,[]):-nl.
process1(C,[C|R]) :- readlist1(R).

gestao(1):-
    write('por implementar1').
gestao(2):-
    write('por implementar2').
gestao(3):-
    write('por implementar3').
gestao(4):-
    write('por implementar4').
gestao(5):-
    write('por implementar5').
gestao(6):-
    write('por implementar6').
gestao(7):-
    write('por implementar7').
gestao(8):-
    write('por implementar8').
gestao(9):-
    write('por implementar9').
gestao(10):-
    write('por implementar10').
gestao(11):-
    write('por implementar11').
gestao(12):-
    write('por implementar12').
gestao(13):-
    write('por implementar13').

% Returns to main menu
gestao(14):-
    run.

consulta(1):-
    write('por implementar').
consulta(2):-
    write('por implementar').
consulta(3):-
    write('por implementar').
consulta(4):-
    write('por implementar').
consulta(5):-
    write('por implementar').
consulta(6):-
    write('por implementar').
consulta(7):-
    write('por implementar').
consulta(8):-
    write('por implementar').
consulta(9):-
    write('por implementar').
consulta(10):-
    run.

% Returns to main menu
consulta(10):-
    run.

bd(1):-
    write('por implementar').

bd(2):-
    write('por implementar').

bd(3):-
    run.






