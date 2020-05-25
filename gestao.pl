adicionar_membro:-
    write('** Adicionar membro à rede. **'),nl,nl,
    opcao_aux('Tipo: ', '[Tipo do membro (clinica, hospital, etc)]', Tipo),
    opcao_aux('Nome: ', '[Nome do membro]', Nome),
    opcao_aux('Localizacao: ', '[Inserir localidade ou cidade]', Localizacao),
    verifica_membro(Tipo, Nome, Localizacao).

adicionar_transporte:-
    write('** Adicionar meio de transporte à rede. ***'), nl,nl,
    opcao_aux('Descricao: ', [carro, carrinha, aviao, etc], Descricao),
    opcao_aux('Velocidade (km/h): ', '[velocidade média do meio de transporte]', Velocidade),
    opcao_aux('Hora (hh:mm): ', '[Hora inicial de funcionamento]', Hora_inicial),
    opcao_aux('Hora final (hh:mm): ', '[Hora final de funcionamento]', Hora_final),
    verifica_meio_transporte(Descricao, Velocidade, Hora_inicial, Hora_final).

adicionar_equipamento:-
    write('** Adicionar equipamentos de protecção existentes nos membros. **\n'),
    opcao_aux('Descricao: ', [mascara, viseira, luvas, alcool, etc], Descricao),
    opcao_aux('Membro: ', '[membro a que pertence]', Membro_pertencente),
    verifica_equipamento(Descricao, Membro_pertencente).

adicionar_ligacao:-
    write('** Adicionar ligação entre membros. **\n\n'),
    opcao_aux('Origem: ', '[Origem da ligação]', Origem),
    opcao_aux('Destino: ', '[Destino da ligação]', Destino),
    opcao_aux('Distância: ', '[Distância entre origem e destino] (km)', Distancia),
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
    opcao_aux('Localização: ', '[Nova localização para o membro]', Nova_localizacao),
    verifica_alterar_membro(Nome, Novo_tipo, Novo_nome, Nova_localizacao).

alterar_equipamento:-
    write('** Alterar equipamento de protecção existentes **\n\n'),
    opcao_aux('Descricao: ', '[Nome do equipamento a alterar]', Descricao),
    opcao_aux('Membro: ', '[Membro a que pertence o equipamento]', Membro_pertencente),
    opcao_aux('Nome: ', '[Novo nome do equipamento]', Novo_nome),
    opcao_aux('Membro: ', '[Novo membro do equipamento]', Novo_membro),
    verifica_alterar_equipamento(Descricao, Membro_pertencente, Novo_nome, Novo_membro).

alterar_ligacao:-
    write('** Alterar ligações entre membros **\n\n'),
    opcao_aux('Origem: ', '[Origem da ligação a alterar]', Origem),
    opcao_aux('Destino: ', '[Destino da ligação a alterar]', Destino),
    opcao_aux('Transporte: ', '[Transporte da ligação a alterar]', Transporte),
    opcao_aux('Origem: ', '[Nova origem da ligação]', Nova_origem),
    opcao_aux('Destino: ', '[Novo destino da ligação]',Novo_destino),
    opcao_aux('Distância: ', '[Nova distação da ligação]', Nova_distancia),
    opcao_aux('Meio de transporte: ', '[Novo meio de transporte da ligação]', Novo_transporte),
    verifica_alterar_ligacao(Origem, Destino, Nova_origem, Novo_destino, Nova_distancia, Transporte, Novo_transporte).

remover_membro:-
    write('** Remover membro da rede de distribuição.\n\n'),
    opcao_aux('Membro: ', '[Membro a remover da rede]', Membro_pretendido),
    verifica_remover_membro(Membro_pretendido).

remover_equipamento:-
    write('** Remover equipamentos existentes nos membros. **\n\n'),
    opcao_aux('Equipamento: ', '[Equipamento a eliminar]', Equipamento_pretendido),
    opcao_aux('Membro: ', '[Membro a que se pretende eliminar o equipamento]', Membro_pretendido),
    verifica_remover_equipamento(Equipamento_pretendido, Membro_pretendido).

remover_ligacao:-
    write('** Remover ligação entre membros da rede **\n\n'),
    opcao_aux('Origem: ', '[Origem da ligação a eliminar]', Origem),
    opcao_aux('Destino: ', '[Destino da ligação a eliminar]',Destino),
    opcao_aux('Transporte: ', '[Transporte da ligação a eliminar]',Transporte),
    verifica_remover_ligacao(Origem, Destino, Transporte).

verifica_membro(Tipo, Nome, Localizacao):-
    membro(_,Nome, _),
    format('~w já existe na rede.\n\n', [Nome]),!;
    assert(membro(Tipo, Nome, Localizacao)),
    format('~w adicionado(a) em ~w.\n\n', [Nome, Localizacao]).

verifica_meio_transporte(Descricao, Velocidade,Hora_inicial,Hora_final):-
    meio_transporte(Descricao,_,_,_),
    format('~w já está presente na rede de distribuição.\n\n', [Descricao]),!;
    % Se tiver tempo proteger o código para o caso em que Hora_final < Hora_inicial
    assert(meio_transporte(Descricao, Velocidade,Hora_inicial,Hora_final)),
    format('~w adicionado(a) à rede de distribuição.\n\n', [Descricao]).

verifica_equipamento(Descricao, Membro_pertencente):-
    equipamento(Descricao, Membro_pertencente),
    format('O membro ~w já tem ~w.\n\n', [Membro_pertencente, Descricao]),!;
    membro(_,Membro_pertencente, _),
    assert(equipamento(Descricao, Membro_pertencente)),
    format('~w adicionado(a) ao membro ~w.\n\n', [Descricao, Membro_pertencente]),!;
    format('O membro ~w não existe na rede.\n\n', [Membro_pertencente]).

verifica_ligacao(Origem, Destino, Distancia, Transporte):-
    ligacao(Origem,Destino,_,Transporte,_,_,_),
    format('A ligação [~w]-[~w] com o transporte [~w] já existe.\n\n', [Origem, Destino, Transporte]),!;
    meio_transporte(Transporte,_,Hora_inicial,Hora_final),
    equipamento(Equip,Origem),
    membro(_,Origem, _),
    membro(_,Destino, _),
    assert(ligacao(Origem, Destino, Distancia, Transporte, Hora_inicial, Hora_final,Equip)),
    format('A ligação [~w]-[~w] com o transporte [~w] foi criada com sucesso.\n\n',[Origem,Destino, Transporte]),!;
    write('Para fazer ligações ambos os membros e o meio de transporte têm que existir na rede de distribuição.\n\n'),nl.

verifica_alterar_membro(Nome, Novo_tipo, Novo_nome, Nova_localizacao):-
    membro(_,Novo_nome,_),
    format('[~w] já existe na rede de distribuição.\n\n', [Novo_nome]),!;
    membro(_,Nome,_),
    retract(membro(_,Nome,_)),
    assert(membro(Novo_tipo, Novo_nome, Nova_localizacao)),
    format('[~w] alterado com sucesso para [~w] com a localização [~w].\n\n', [Nome, Novo_nome, Nova_localizacao]),!;
    format('[~w] não existe na rede de distribuição.\n\n', [Nome]).

verifica_alterar_transporte(Transporte, Novo_nome, Nova_velocidade, Nova_hora_inicial, Nova_hora_final):-
    meio_transporte(Novo_nome,_,_,_),
    format('[~w] já existe nos meios de transporte.\n\n',[Novo_nome]),!;
    meio_transporte(Transporte,_,_,_),
    retract(meio_transporte(Transporte,_,_,_)),
    assert(meio_transporte(Novo_nome, Nova_velocidade, Nova_hora_inicial, Nova_hora_final)),
    format('[~w] alterado com sucesso para [~w] com uma velocidade de [~w] km/h e um horário de funcionamento entre as [~w] e as [~w].\n\n', [Transporte, Novo_nome, Nova_velocidade, Nova_hora_inicial, Nova_hora_final]),!;
    format('[~w] não existe nos meios de transporte.\n\n',[Transporte]).

verifica_alterar_equipamento(Descricao, Membro_pertencente, Novo_nome, Novo_membro):-
    equipamento(Novo_nome,Novo_membro),
    format('O membro [~w] já possui [~w].\n\n', [Novo_nome,Novo_membro]),!;
    equipamento(Descricao,Membro_pertencente),
    retract(equipamento(Descricao,Membro_pertencente)),
    assert(equipamento(Novo_nome, Novo_membro)),
    format('[~w] alterado com sucesso para [~w] do membro [~w] para o membro [~w].\n\n', [Descricao, Novo_nome, Membro_pertencente, Novo_membro]),!;
    format('O membro [~w] não possui o equipamento [~w], portanto não é possível alterar.\n\n', [Membro_pertencente,Descricao]).

verifica_alterar_ligacao(Origem, Destino, Nova_origem, Novo_destino, Nova_distancia, Transporte, Novo_transporte):-
    ligacao(Nova_origem, Novo_destino,_,Novo_transporte,_,_,_),
    format('A ligação [~w]-[~w] com o transporte [~w] já existe.\n\n', [Nova_origem, Novo_destino, Novo_transporte]),!;
    ligacao(Origem, Destino,_,Transporte,_,_,_),
    retract(ligacao(Origem, Destino,_,Transporte,_,_,_)),
    meio_transporte(Novo_transporte,_,Hora_inicial,Hora_final),
    equipamento(Equipamento,Nova_origem),
    assert(ligacao(Nova_origem, Novo_destino, Nova_distancia, Novo_transporte,Hora_inicial, Hora_final,Equipamento)),
    format('A ligação [~w]-[~w] de [~w] foi alterada com sucesso para [~w]-[~w] de [~w].\n\n', [Origem,Destino,Transporte,Nova_origem,Novo_destino,Novo_transporte]),!;
    format('A ligação [~w]-[~w] de [~w] não existe.\n\n', [Origem,Destino,Transporte]).

verifica_remover_membro(Membro_pretendido):-
    membro(_,Membro_pretendido,_),
    % falta eliminar o equipamento e as ligacoes onde o membro pretendido se encontre
    remover_membro_equipamento(Membro_pretendido),
    remover_membro_ligacoes(Membro_pretendido),
    retract(membro(_,Membro_pretendido,_)),
    format('O membro [~w] foi eliminado da rede.\n\n', [Membro_pretendido]),!;
    format('O membro [~w] não existe na rede.\n\n', [Membro_pretendido]).

verifica_membros_cidade(Cidade):-
    membro(_,_,Cidade),
    findall(M, membro(_,M,Cidade),Lista),
    format('Na cidade [~w] temos os seguintes membros:\n', [Cidade]),
    write(Lista),nl,nl,!;
    format('Não existe nenhum membro com a localizacao [~w].\n\n',[Cidade]).

% Remove as ligações e os equipamentos pertencentes ao membro a eliminar
remover_membro_equipamento(Membro_pretendido):-
    ( equipamento(_, Membro_pretendido) ->
            retractall(equipamento(_,Membro_pretendido)),
            format('Os equipamentos pertencentes ao membro [~w] foram eliminados.\n\n', [Membro_pretendido])
            ;
            format('O membro [~w] não tem equipamentos a eliminar.\n\n', [Membro_pretendido])
    ).

remover_membro_ligacoes(Membro_pretendido):-
    ( ligacao(Membro_pretendido,_,_,_,_,_,_) ->
            retractall(ligacao(Membro_pretendido,_,_,_)),
            format('As ligações com origem no membro [~w] foram eliminadas.\n\n', [Membro_pretendido])
            ;
            format('Não há ligações com o membro [~w] na origem a eliminar.\n\n', [Membro_pretendido])
    ),

    ( ligacao(_,Membro_pretendido,_,_,_,_,_) ->
                         retractall(ligacao(_,Membro_pretendido,_,_,_,_)),
                         format('As ligações com destino no membro [~w] foram eliminadas.\n\n', [Membro_pretendido])
                         ;
                         format('Não há ligações com o membro [~w] no destino a eliminar.\n\n', [Membro_pretendido])
    ).

verifica_remover_equipamento(Equipamento_pretendido, Membro_pretendido):-
    equipamento(Equipamento_pretendido, Membro_pretendido),
    retract(equipamento(Equipamento_pretendido, Membro_pretendido)),
    format('[~w] eliminado do membro [~w].\n\n', [Equipamento_pretendido, Membro_pretendido]),!;
    format('O membro [~w] não tem o equipamento [~w].\n\n', [Membro_pretendido, Equipamento_pretendido]).

verifica_remover_ligacao(Origem, Destino, Transporte):-
    ligacao(Origem, Destino,_,Transporte,_,_,_),
    retract(ligacao(Origem, Destino,_,_,_,_,_)),
    format('A ligação [~w]-[~w] de [~w] foi removida com sucesso.\n\n', [Origem, Destino, Transporte]),!;
    format('A ligação [~w]-[~w] de [~w] não existe.\n\n', [Origem, Destino, Transporte]).









