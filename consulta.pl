listar_membros:-
    findall([Tipo,Nome,Localizacao], membro(Tipo, Nome, Localizacao), Lista_membros),
    write('Membros da rede de distribuição:\n\n'),
    (   Lista_membros = [] ->
                write(Lista_membros),nl,nl;
                pretty_display(Lista_membros,'Membro '),nl
    ).


listar_equipamento:-
    findall([Descricao,Membro_pertencente], equipamento(Descricao, Membro_pertencente), Lista_equipamento),
    write('Equipamentos de proteção e membro correspondente:\n\n'),
    (   Lista_equipamento = [] ->
                 write(Lista_equipamento),nl,nl;
                 pretty_display(Lista_equipamento,'Equipamento '),nl
    ).

listar_cidades:-
    write('** Listar cidades por tipo de membro **\n\n'),
    opcao_aux('Tipo: ', '[Tipo de membro]', Tipo),
    findall([Localizacao], membro(Tipo,_,Localizacao), Lista),
    uniq(Lista, Lista_atualizada),
    format('Cidades onde existem membros do tipo [~w]:\n\n', [Tipo]),
    (   Lista_atualizada = [] ->
                 write(Lista_atualizada),nl,nl;
                 pretty_display(Lista_atualizada,'Cidade '),nl
    ).

% sort -> ordena e remove os valores duplicados.
uniq(Data,Uniques):- sort(Data, Uniques).

% Listar transportes e horários entre dois membros
listar_transportes_horarios:-
    write('** Listar transportes e horários disponíveis entre dois membros **\n\n'),
    opcao_aux('Membro 1: ', '[Insira o primeiro membro]', Membro_1),
    opcao_aux('Membro 2: ', '[Insira o segundo membro]', Membro_2),
    transportes_horarios(Membro_1, Membro_2).

transportes_horarios(Membro_1, Membro_2):-
    % Lista_1 -> transportes membro_1-membro_2
    findall([Transporte,Hora_inicial,Hora_final], ligacao(Membro_1,Membro_2,_,Transporte,Hora_inicial, Hora_final,_), Lista_1),
    % Lista_2 -> transportes membro_2-membro_1
    findall([Transporte,Hora_inicial,Hora_final], ligacao(Membro_2,Membro_1,_,Transporte,Hora_inicial,Hora_final,_), Lista_2),
    % Lista_3 -> Lista_1+Lista_2
    append(Lista_1,Lista_2,Lista_3),
    format('Os transportes disponíveis para viagens entre [~w] e [~w] com os respetivos horários são:\n\n', [Membro_1,Membro_2]),
    (   Lista_3 = [] ->
               write(Lista_3),nl,nl;
               pretty_display(Lista_3,'Transporte '),nl
    ).
% falta a distancia total
listar_itinerarios_membros:-
    write('** Listar itinerários possíveis entre dois membros **\n\n'),
    opcao_aux('Origem: ', '[membro de origem]', Origem),
    opcao_aux('Destino: ', '[membro de destino]', Destino),
    membro(_,Origem,_),
    membro(_,Destino,_),
    findall([A,Distancia],caminho(Origem,Destino,A,Distancia),Lista),
    write('Os itinerários possíveis são:'),nl,
    pretty_display(Lista,'Itinerário '),nl,!;
    write('Ambos os membros têm de pertencer à rede.\n\n').

caminho(A,B,[via(A,B)],Distancia):-
    ligacao(A,B,Distancia,_,_,_,_).

caminho(A,B,[via(A,C)|D],Distancia):-
    ligacao(A,C,D1,_,_,_,_),
    caminho(C,B,D,D2),
    Distancia is D1+D2.

listar_menor_itinerario:-
    write('** Listar menor itinerário entre dois membros **\n\n'),
    opcao_aux('Origem: ', '[membro de origem]', Origem),
    opcao_aux('Destino: ', '[membro de destino]', Destino),
    membro(_,Origem,_),
    membro(_,Destino,_),
    findall(Distancia,caminho(Origem,Destino,_,Distancia),Lista_1),
    find_min(Lista_1,Min),
    findall(Iti,(caminho(aqualab,'cuf evora',Iti,D),D=Min),Lista_2),
    pretty_display(Lista_2,'Itinerário '),
    format('Distância: ~w km.',[Min]),nl,nl,!;
    write('Ambos os membros necessitam de estar na rede de distribuição.\n\n').

find_min([L|Ls], Min):-
    find_min(Ls, L, Min).

find_min([], Min, Min).

find_min([L|Ls],Min0, Min):-
    Min1 is min(L,Min0),
    find_min(Ls,Min1,Min).

listar_maior_itinerario:-
    write('** Listar maior itinerário entre dois membros **\n\n'),
    opcao_aux('Origem: ', '[membro de origem]', Origem),
    opcao_aux('Destino: ', '[membro de destino]', Destino),
    membro(_,Origem,_),
    membro(_,Destino,_),
    findall(Distancia,caminho(Origem,Destino,_,Distancia),Lista_1),
    find_max(Lista_1, Max),
    findall(Iti,(caminho(aqualab,'cuf evora',Iti,D),D=Max),Lista_2),
    pretty_display(Lista_2,'Itinerário '),
    format('Distância: ~w km.',[Max]),nl,nl,!;
    write('Ambos os membros necessitam de estar na rede de distribuição.\n\n').

find_max([L|Ls],Max):-
    foldl(num_max,Ls,L,Max).

num_max(X,Y,Max):-
    Max is max(X,Y).

listar_itinerarios_ponto_intermedio:-
    write('** Listar itinerários entre dois membros, passando por um ou dois membros **\n\n').


listar_itinerarios_equipamento:-
    write('** Listar itinerários entre dois membros, passando por membros que possuam determinados equipamentos **\n\n').

obter_membros_cidade:-
    write('** Obter membros numa cidade **\n\n'),
    opcao_aux('Cidade: ', '[cidade pretendida]', Cidade),
    verifica_membros_cidade(Cidade).

centralidade_membro:-
    write('** Obter o grau de centralidade de um membro **\n\n'),
    opcao_aux('Membro: ', '[membro pretendido]', Membro_pretendido),
    % Temos que descobrir quantas vezes o Membro_pretendido é o destino
    findall(L,ligacao(L,Membro_pretendido,_,_,_,_,_),Lista),
    %Lista contem o outro membro da ligacao
    %Basta obtermos o comprimento da Lista e dividirmos o comprimento por (membros_total-1) para obtermos o grau de centralidade normalizado
    len(Lista,Grau_entrada),
    findall(G,membro(G,_,_),Lista_membros),
    len(Lista_membros,Num_membros),
    calcula_grau_normalizado(Grau_entrada,Num_membros,Grau_normalizado),
    format('O membro [~w] tem um grau de centralidade de entrada (normalizado) de: [~6f].\n\n', [Membro_pretendido,Grau_normalizado]).

calcula_grau_normalizado(Grau_entrada,Num_membros,Grau_normalizado):-
    Grau_normalizado is Grau_entrada/(Num_membros-1).

len([], LenResult):-
    LenResult is 0.

len([_X|Y], LenResult):-
    len(Y, L),
    LenResult is L + 1.

