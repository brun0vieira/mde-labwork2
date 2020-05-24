:-dynamic membro/3. % membro - tipo, nome, localizacao
:-dynamic meio_transporte/4. % meio de transporte - descricao, velocidade (km/h), hora_inicial, hora_final
:-dynamic equipamento/2. % equipamento - descricao, membro pertencente
:-dynamic ligacao/4. % ligacao - origem, destino, distancia, meio de transporte

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
    write('  4. Adicionar liga��es entre membros.'),nl,nl,
    write('  5. Alterar meios de transporte.'),nl,
    write('  6. Alterar membros da rede.'),nl,
    write('  7. Alterar equipamentos de protec��o existentes nos membros.'),nl,
    write('  8. Alterar liga��es entre membros.'),nl,
    write('  9. Alterar ...'),nl,nl,
    write('10. Remover membros da rede.'),nl,
    write('11. Remover equipamentos de protec��o existentes nos membros.'),nl,
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
    write('  3. Listar cidades por tipo de membro.'),nl,
    write('  4. Listar transportes e hor�rios dispon�veis entre dois membros.'),nl,
    write('  5. Listar itiner�rios entre membros.'),nl,nl,
    write('  6. Obter itiner�rio entre membros com menor distancia'),nl,
    write('  7. Obter itiner�rio entre membros com maior dist�ncia.'),nl,
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

adicionar_membro:-
    write('** Adicionar membro � rede. **'),nl,nl,
    opcao_aux('Tipo: ', '[Tipo do membro (clinica, hospital, etc)]', Tipo),
    opcao_aux('Nome: ', '[Nome do membro]', Nome),
    opcao_aux('Localizacao: ', '[Inserir localidade ou cidade]', Localizacao),
    verifica_membro(Tipo, Nome, Localizacao).

adicionar_transporte:-
    write('** Adicionar meio de transporte � rede. ***'), nl,nl,
    opcao_aux('Descricao: ', [carro, carrinha, aviao, etc], Descricao),
    opcao_aux('Velocidade (km/h): ', '[velocidade m�dia do meio de transporte]', Velocidade),
    opcao_aux('Hora (hh:mm): ', '[Hora inicial de funcionamento]', Hora_inicial),
    opcao_aux('Hora final (hh:mm): ', '[Hora final de funcionamento]', Hora_final),
    verifica_meio_transporte(Descricao, Velocidade, Hora_inicial, Hora_final).

adicionar_equipamento:-
    write('** Adicionar equipamentos de protec��o existentes nos membros. **\n'),
    opcao_aux('Descricao: ', [mascara, viseira, luvas, alcool, etc], Descricao),
    opcao_aux('Membro: ', '[membro a que pertence]', Membro_pertencente),
    verifica_equipamento(Descricao, Membro_pertencente).

adicionar_ligacao:-
    write('** Adicionar liga��o entre membros. **\n\n'),
    opcao_aux('Origem: ', '[Origem da liga��o]', Origem),
    opcao_aux('Destino: ', '[Destino da liga��o]', Destino),
    opcao_aux('Dist�ncia: ', '[Dist�ncia entre origem e destino] (km)', Distancia),
    opcao_aux('Transporte: ', '[Meio de transporte para a viagem]', Transporte),
    verifica_ligacao(Origem, Destino, Distancia, Transporte).

alterar_meio_transporte:-
    write('** Alterar meios de transporte **\n\n'),
    opcao_aux('Transporte: ', '[Meio de transporte a alterar]', Transporte),
    opcao_aux('Nome: ', '[Novo nome para o transporte a alterar]', Novo_nome),
    opcao_aux('Velocidade: ', '[Nova velocidade]', Nova_velocidade),
    opcao_aux('Hora inicial: ', '[Nova hora inicial de funcionamento]', Nova_hora_inicial),
    opcao_aux('Hora final: ', '[Nova hora final de funcionamento]', Nova_hora_final),
    verifica_alterar_transporte(Transporte, Novo_nome, Nova_velocidade, Nova_hora_inicial, Nova_hora_final).

alterar_membro:-
    write('** Alterar membro **\n\n'),
    opcao_aux('Membro: ', '[Membro a alterar]', Nome),
    opcao_aux('Tipo: ', '[Novo tipo para o membro]', Novo_tipo),
    opcao_aux('Nome: ', '[Novo nome para o membro]', Novo_nome),
    opcao_aux('Localiza��o: ', '[Nova localiza��o para o membro]', Nova_localizacao),
    verifica_alterar_membro(Nome, Novo_tipo, Novo_nome, Nova_localizacao).

alterar_equipamento:-
    write('** Alterar equipamento de protec��o existentes **\n\n'),
    opcao_aux('Descricao: ', '[Nome do equipamento a alterar]', Descricao),
    opcao_aux('Membro: ', '[Membro a que pertence o equipamento]', Membro_pertencente),
    opcao_aux('Nome: ', '[Novo nome do equipamento]', Novo_nome),
    opcao_aux('Membro: ', '[Novo membro do equipamento]', Novo_membro),
    verifica_alterar_equipamento(Descricao, Membro_pertencente, Novo_nome, Novo_membro).

alterar_ligacao:-
    write('** Alterar liga��es entre membros **\n\n'),
    opcao_aux('Origem: ', '[Origem da liga��o a alterar]', Origem),
    opcao_aux('Destino: ', '[Destino da liga��o a alterar]', Destino),
    opcao_aux('Transporte: ', '[Transporte da liga��o a alterar]', Transporte),
    opcao_aux('Origem: ', '[Nova origem da liga��o]', Nova_origem),
    opcao_aux('Destino: ', '[Novo destino da liga��o]',Novo_destino),
    opcao_aux('Dist�ncia: ', '[Nova dista��o da liga��o]', Nova_distancia),
    opcao_aux('Meio de transporte: ', '[Novo meio de transporte da liga��o]', Novo_transporte),
    verifica_alterar_ligacao(Origem, Destino, Nova_origem, Novo_destino, Nova_distancia, Transporte, Novo_transporte).

remover_membro:-
    write('** Remover membro da rede de distribui��o.\n\n'),
    opcao_aux('Membro: ', '[Membro a remover da rede]', Membro_pretendido),
    verifica_remover_membro(Membro_pretendido).

remover_equipamento:-
    write('** Remover equipamentos existentes nos membros. **\n\n'),
    opcao_aux('Equipamento: ', '[Equipamento a eliminar]', Equipamento_pretendido),
    opcao_aux('Membro: ', '[Membro a que se pretende eliminar o equipamento]', Membro_pretendido),
    verifica_remover_equipamento(Equipamento_pretendido, Membro_pretendido).

remover_ligacao:-
    write('** Remover liga��o entre membros da rede **\n\n'),
    opcao_aux('Origem: ', '[Origem da liga��o a eliminar]', Origem),
    opcao_aux('Destino: ', '[Destino da liga��o a eliminar]',Destino),
    opcao_aux('Transporte: ', '[Transporte da liga��o a eliminar]',Transporte),
    verifica_remover_ligacao(Origem, Destino, Transporte).

%-----------------------------------------------------------
% Consulta � base de conhecimentos
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
    findall([Tipo,Nome,Localizacao], membro(Tipo, Nome, Localizacao), Lista_membros),
    format('Membros da rede:\n~w\n\n', [Lista_membros]).

listar_equipamento:-
    findall([Descricao,Membro_pertencente], equipamento(Descricao, Membro_pertencente), Lista_equipamento),
    format('Equipamentos:\n~w\n\n', [Lista_equipamento]).

/*
listar_ligacoes:-
    findall([Origem, Destino, Distancia, Transporte], ligacao(Origem, Destino, Distancia, Transporte), Lista),
    format('Liga��es:\n~w\n\n', [Lista]).

listar_transporte:-
    findall([Descricao, Velocidade, Hora_inicial, Hora_final], meio_transporte(Descricao, Velocidade, Hora_inicial, Hora_final), Lista),
    format('Meios de transporte:\n~w\n\n', [Lista]).
*/
listar_cidades:-
    write('** Listar cidades por tipo de membro **\n\n'),
    opcao_aux('Tipo: ', '[Tipo de membro]', Tipo),
    findall([Localizacao], membro(Tipo,_,Localizacao), Lista),
    % falta remover os valores duplicados na Lista
    uniq(Lista, Lista_atualizada),
    format('Cidades onde existem membros do tipo [~w]:\n~w\n\n', [Tipo, Lista_atualizada]).

% sort -> ordena e remove os valores duplicados.
uniq(Data,Uniques):- sort(Data, Uniques).

% Listar transportes e hor�rios entre dois membros
listar_transportes_horarios:-
    write('** Listar transportes e hor�rios dispon�veis entre dois membros **\n\n'),
    opcao_aux('Membro 1: ', '[Insira o primeiro membro]', Membro_1),
    opcao_aux('Membro 2: ', '[Insira o segundo membro]', Membro_2),
    listar_transportes_membros(Membro_1, Membro_2).

listar_transportes_membros(Membro_1, Membro_2):-
    % Lista_1 -> transportes membro_1-membro_2
    findall([Transporte], ligacao(Membro_1,Membro_2,_,Transporte), Lista_1),
    % Lista_2 -> transportes membro_2-membro_1
    findall([Transporte], ligacao(Membro_2,Membro_1,_,Transporte), Lista_2),
    % Lista_3 -> Lista_1+Lista_2
    append(Lista_1,Lista_2,Lista_3),
    format('Os transportes dispon�veis para viagens entre [~w] e [~w] s�o:\n~w.\n\n', [Membro_1,Membro_2,Lista_3]).

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

verifica_membro(Tipo, Nome, Localizacao):-
    membro(_,Nome, _),
    format('~w j� existe na rede.\n\n', [Nome]),!;
    assert(membro(Tipo, Nome, Localizacao)),
    format('~w adicionado(a) em ~w.\n\n', [Nome, Localizacao]).

verifica_meio_transporte(Descricao, Velocidade,Hora_inicial,Hora_final):-
    meio_transporte(Descricao,_,_,_),
    format('~w j� est� presente na rede de distribui��o.\n\n', [Descricao]),!;
    % Se tiver tempo proteger o c�digo para o caso em que Hora_final < Hora_inicial
    assert(meio_transporte(Descricao, Velocidade,Hora_inicial,Hora_final)),
    format('~w adicionado(a) � rede de distribui��o.\n\n', [Descricao]).

verifica_equipamento(Descricao, Membro_pertencente):-
    equipamento(Descricao, Membro_pertencente),
    format('O membro ~w j� tem ~w.\n\n', [Membro_pertencente, Descricao]),!;
    membro(_,Membro_pertencente, _),
    assert(equipamento(Descricao, Membro_pertencente)),
    format('~w adicionado(a) ao membro ~w.\n\n', [Descricao, Membro_pertencente]),!;
    format('O membro ~w n�o existe na rede.\n\n', [Membro_pertencente]).

verifica_ligacao(Origem, Destino, Distancia, Transporte):-
    ligacao(Origem,Destino,_,Transporte),
    format('A liga��o [~w]-[~w] com o transporte [~w] j� existe.\n\n', [Origem, Destino, Transporte]),!;
    meio_transporte(Transporte,_,_,_),
    membro(_,Origem, _),
    membro(_,Destino, _),
    assert(ligacao(Origem, Destino, Distancia, Transporte)),
    format('A liga��o [~w]-[~w] com o transporte [~w] foi criada com sucesso.\n\n',[Origem,Destino, Transporte]),!;
    write('Para fazer liga��es ambos os membros e o meio de transporte t�m que existir na rede de distribui��o.\n\n'),nl.

verifica_alterar_membro(Nome, Novo_tipo, Novo_nome, Nova_localizacao):-
    membro(_,Novo_nome,_),
    format('[~w] j� existe na rede de distribui��o.\n\n', [Novo_nome]),!;
    membro(_,Nome,_),
    retract(membro(_,Nome,_)),
    assert(membro(Novo_tipo, Novo_nome, Nova_localizacao)),
    format('[~w] alterado com sucesso para [~w] com a localiza��o [~w].\n\n', [Nome, Novo_nome, Nova_localizacao]),!;
    format('[~w] n�o existe na rede de distribui��o.\n\n', [Nome]).

verifica_alterar_transporte(Transporte, Novo_nome, Nova_velocidade, Nova_hora_inicial, Nova_hora_final):-
    meio_transporte(Novo_nome,_,_,_),
    format('[~w] j� existe nos meios de transporte.\n\n',[Novo_nome]),!;
    meio_transporte(Transporte,_,_,_),
    retract(meio_transporte(Transporte,_,_,_)),
    assert(meio_transporte(Novo_nome, Nova_velocidade, Nova_hora_inicial, Nova_hora_final)),
    format('[~w] alterado com sucesso para [~w] com uma velocidade de [~w] km/h e um hor�rio de funcionamento entre as [~w] e as [~w].\n\n', [Transporte, Novo_nome, Nova_velocidade, Nova_hora_inicial, Nova_hora_final]),!;
    format('[~w] n�o existe nos meios de transporte.\n\n',[Transporte]).

verifica_alterar_equipamento(Descricao, Membro_pertencente, Novo_nome, Novo_membro):-
    equipamento(Novo_nome,Novo_membro),
    format('O membro [~w] j� possui [~w].\n\n', [Novo_nome,Novo_membro]),!;
    equipamento(Descricao,Membro_pertencente),
    retract(equipamento(Descricao,Membro_pertencente)),
    assert(equipamento(Novo_nome, Novo_membro)),
    format('[~w] alterado com sucesso para [~w] do membro [~w] para o membro [~w].\n\n', [Descricao, Novo_nome, Membro_pertencente, Novo_membro]),!;
    format('O membro [~w] n�o possui o equipamento [~w], portanto n�o � poss�vel alterar.\n\n', [Membro_pertencente,Descricao]).

verifica_alterar_ligacao(Origem, Destino, Nova_origem, Novo_destino, Nova_distancia, Transporte, Novo_transporte):-
    ligacao(Nova_origem, Novo_destino,_,Novo_transporte),
    format('A liga��o [~w]-[~w] com o transporte [~w] j� existe.\n\n', [Nova_origem, Novo_destino, Novo_transporte]),!;
    ligacao(Origem, Destino,_,Transporte),
    retract(ligacao(Origem, Destino,_,Transporte)),
    assert(ligacao(Nova_origem, Novo_destino, Nova_distancia, Novo_transporte)),
    format('A liga��o [~w]-[~w] de [~w] foi alterada com sucesso para [~w]-[~w] de [~w].\n\n', [Origem,Destino,Transporte,Nova_origem,Novo_destino,Novo_transporte]),!;
    format('A liga��o [~w]-[~w] de [~w] n�o existe.\n\n', [Origem,Destino,Transporte]).

verifica_remover_membro(Membro_pretendido):-
    membro(_,Membro_pretendido,_),
    % falta eliminar o equipamento e as ligacoes onde o membro pretendido se encontre
    remover_membro_equipamento(Membro_pretendido),
    remover_membro_ligacoes(Membro_pretendido),
    retract(membro(_,Membro_pretendido,_)),
    format('O membro [~w] foi eliminado da rede.\n\n', [Membro_pretendido]),!;
    format('O membro [~w] n�o existe na rede.\n\n', [Membro_pretendido]).

% Remove as liga��es e os equipamentos pertencentes ao membro a eliminar
remover_membro_equipamento(Membro_pretendido):-
    ( equipamento(_, Membro_pretendido) ->
            retractall(equipamento(_,Membro_pretendido)),
            format('Os equipamentos pertencentes ao membro [~w] foram eliminados.\n\n', [Membro_pretendido])
            ;
            format('O membro [~w] n�o tem equipamentos a eliminar.\n\n', [Membro_pretendido])
    ).

remover_membro_ligacoes(Membro_pretendido):-
    ( ligacao(Membro_pretendido,_,_,_) ->
            retractall(ligacao(Membro_pretendido,_,_,_)),
            format('As liga��es com origem no membro [~w] foram eliminadas.\n\n', [Membro_pretendido])
            ;
            format('N�o h� liga��es com o membro [~w] na origem a eliminar.\n\n', [Membro_pretendido])
    ),

    ( ligacao(_,Membro_pretendido,_,_) ->
                         retractall(ligacao(_,Membro_pretendido,_,_)),
                         format('As liga��es com destino no membro [~w] foram eliminadas.\n\n', [Membro_pretendido])
                         ;
                         format('N�o h� liga��es com o membro [~w] no destino a eliminar.\n\n', [Membro_pretendido])
    ).

verifica_remover_equipamento(Equipamento_pretendido, Membro_pretendido):-
    equipamento(Equipamento_pretendido, Membro_pretendido),
    retract(equipamento(Equipamento_pretendido, Membro_pretendido)),
    format('[~w] eliminado do membro [~w].\n\n', [Equipamento_pretendido, Membro_pretendido]),!;
    format('O membro [~w] n�o tem o equipamento [~w].\n\n', [Membro_pretendido, Equipamento_pretendido]).

verifica_remover_ligacao(Origem, Destino, Transporte):-
    ligacao(Origem, Destino,_,Transporte),
    retract(ligacao(Origem, Destino,_,_)),
    format('A liga��o [~w]-[~w] de [~w] foi removida com sucesso.\n\n', [Origem, Destino, Transporte]),!;
    format('A liga��o [~w]-[~w] de [~w] n�o existe.\n\n', [Origem, Destino, Transporte]).

voltar_menu_anterior:-
    write('Pressione \'1\' para voltar ao menu anterior.'), nl,
    ler_opcao(_Opcao, 1, 1).












