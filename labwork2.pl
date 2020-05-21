:-dynamic membro/2. % membro - nome, localizacao
:-dynamic meio_transporte/2. % meio de transporte - descricao, velocidade (km/h)
:-dynamic equipamento/2. % equipamento - descricao, membro pertencente
run:-
    limpar_ecra,
    write('MENU'),nl,nl,
    menu(Opcao),
    menu_principal(Opcao),
    run.

menu(Opcao):-
    write('1. Gest�o da base de conhecimento.'),nl,
    write('2. Consultas � base de conhecimento.'),nl,
    write('3. Base de dados.'),nl,
    write('4. Mais informa��es.'),nl,
    write('5. Sair.'),nl,
    ler_opcao(Opcao, 1, 5).

ler_opcao(Opcao, A, B):-
    nl, write('Op��o: '),
    ler_buffer(S),
    atom_number(S, Opcao),
    opcao_valida(Opcao, A, B),nl.

ler_opcao(Opcao, A, B):-
    nl, write('*** Opcao inv�lida. Tente outra vez: '),
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
    write('Gest�o da base de conhecimento'),nl,nl,
    write('  1. Adicionar membros da rede.'),nl,
    write('  2. Adicionar meios de transporte.'),nl,
    write('  3. Adicionar equipamentos de protec��o existentes nos membros.'),nl,
    write('  4. Adicionar liga��es entre membros.'),nl,
    write('  5. Adicionar ...'),nl,nl,
    write('  6. Alterar membros da rede.'),nl,
    write('  7. Alterar equipamentos de protec��o existentes nos membros.'),nl,
    write('  8. Alterar liga��es entre membros.'),nl,
    write('  9. Alterar ...'),nl,nl,
    write('10. Remover membros da rede.'),nl,
    write('11. Remover de protec��o existentes nos membros.'),nl,
    write('12. Remover liga��es entre membros'),nl,
    write('13. Remover ...'),nl,nl,
    write('14. Voltar ao menu anterior.'),nl,
    ler_opcao(Opcao, 1, 14),
    limpar_ecra,
    gestao(Opcao),
    voltar_menu_anterior,
    menu_gestao.

menu_consulta:-
    limpar_ecra,
    write('Consultas � base de conhecimento'),nl,nl,
    write('  1. Listar membros da rede.'),nl,
    write('  2. Listar equipamentos de protec��o existentes.'),nl,
    write('  3. Listar cidades por equipamento existente.'),nl,
    write('  4. Listar itiner�rios entre membros.'),nl,nl,
    write('  5. Obter itiner�rio entre membros com menor distancia'),nl,
    write('  6. Obter itiner�rio entre membros com maior dist�ncia.'),nl,
    write('  8. Obter itiner�rio entre membros com passagem por outros membros.'),nl,
    write('  9. Obter ...'),nl,nl,
    write('10. Voltar ao menu anterior.'),nl,
    ler_opcao(Opcao, 1, 10),
    limpar_ecra,
    consulta(Opcao),
    voltar_menu_anterior,
    menu_consulta.

base_dados:-
    limpar_ecra,
    write('Opera��es sobre a base de dados'),nl,nl,
    write('  1. Importar base de dados'),nl,
    write('  2. Eliminar base de dados'),nl,nl,
    write('  3. Voltar ao menu anterior.'),nl,
    ler_opcao(Opcao, 1, 3),
    bd(Opcao),
    base_dados.

info:-
    limpar_ecra,
    write('Projecto n�2 de MDE realizado por:'), nl,
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
% Gest�o da base de conhecimento
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
    write('por implementar5').
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

adicionar_membro:-
    write('** Adicionar membro � rede. **'),nl,nl,
    opcao_aux('Nome: ', [clinica, hospital, supermercado, etc], Nome),
    opcao_aux('Localizacao: ', '[Inserir localidade ou cidade]', Localizacao),
    verifica_membro(Nome, Localizacao).

adicionar_transporte:-
    write('** Adicionar meio de transporte � rede. ***'), nl,nl,
    opcao_aux('Descricao: ', [carro, carrinha, aviao, etc], Descricao),
    opcao_aux('Velocidade (km/h): ', '[velocidade m�dia do meio de transporte]', Velocidade),
    verifica_meio_transporte(Descricao, Velocidade).

adicionar_equipamento:-
    write('** Adicionar equipamentos de protec��o existentes nos membros. **'),nl,
    opcao_aux('Descricao: ', [mascara, viseira, luvas, alcool, etc], Descricao),
    opcao_aux('Membro: ', '[membro a que pertence]', Membro_pertencente),
    verifica_equipamento(Descricao, Membro_pertencente).

adicionar_ligacao:-
    write('Adicionar ligacao').
alterar_membro:-
    write('Alterar membro').
alterar_equipamento:-
    write('Alterar equipamento').
alterar_ligacao:-
    write('Alterar ligacao').
remover_membro:-
    write('Remover membro').
remover_equipamento:-
    write('Remover equipamento').
remover_ligacao:-
    write('Remover ligacao').
%-----------------------------------------------------------
% Consulta � base de conhecimentos
%-----------------------------------------------------------

consulta(1):-
    listar_membros.
consulta(2):-
    listar_equipamento.
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

listar_membros:-
    findall([Nome,Localizacao], membro(Nome, Localizacao), Lista_membros),
    format('Membros da rede:\n~w\n\n', [Lista_membros]).

listar_equipamento:-
    findall([Descricao,Membro_pertencente], equipamento(Descricao, Membro_pertencente), Lista_equipamento),
    format('Equipamentos:\n~w\n\n', [Lista_equipamento]).

bd(1):-
    write('por implementar').

bd(2):-
    write('por implementar').

bd(3):-
    run.

% Funcoes auxiliares

opcao_aux(Imprime, Opcoes, Opcao):-
    write(Opcoes),nl,
    write(Imprime),
    ler_buffer(Opcao).

verifica_membro(Nome, Localizacao):-
    membro(Nome, _),
    format('~w j� existe na rede.\n\n', [Nome]),!;
    assert(membro(Nome, Localizacao)),
    format('~w adicionado(a) em ~w.\n\n', [Nome, Localizacao]).

verifica_meio_transporte(Descricao, Velocidade):-
    meio_transporte(Descricao, _),
    format('~w j� est� presente na rede de distribui��o.\n\n', [Descricao]),!;
    assert(meio_transporte(Descricao, Velocidade)),
    format('~w adicionado(a) � rede de distribui��o.\n\n', [Descricao]).

verifica_equipamento(Descricao, Membro_pertencente):-
    equipamento(Descricao, Membro_pertencente),
    format('O membro ~w j� tem ~w.\n\n', [Membro_pertencente, Descricao]),!;
    membro(Membro_pertencente, _),
    assert(equipamento(Descricao, Membro_pertencente)),
    format('~w adicionado(a) ao membro ~w.\n\n', [Descricao, Membro_pertencente]),!;
    format('O membro ~w n�o existe na rede.\n\n', [Membro_pertencente]).

% Se for preciso usar stock voltar aqui e fazer respetivas mudan�as
/*
% Se o equipamento j� existe, incrementa-se o stock.
% Caso contr�rio, adiciona-se o equipamento com o respetivo stock.

verifica_equipamento(Descricao, Membro_pertencente, Stock):-
    equipamento(Descricao, Membro_pertencente,_),
    format('O membro ~w j� tem ~w ~w.', [Membro_pertencente,, Descricao]),
    retract(equipamento(Descricao, Membro_pertencente, _)),
    assert(equipamento(Descricao, Membro_pertencente, Stock)),
    format('Acabou de ser adicionado ~w ~w ao membro ~w.',[Stock, Descricao, Membro_pertencente]),!;
    assert(equipamento(Descricao, Membro_pertencente, Stock)),
    format('Foi adicionado ~w ~w ao membro ~w', [Stock, Descricao, Membro_pertencente]).
*/

voltar_menu_anterior:-
    write('Pressione \'1\' para voltar ao menu anterior.'), nl,
    ler_opcao(_Opcao, 1, 1).













