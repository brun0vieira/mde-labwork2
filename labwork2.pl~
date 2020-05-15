run:-
    nl,nl,write('MENU'),nl,nl,
    menu(Opcao),
    executa(Opcao).

menu(Opcao):-
    write('1. Gestão da base de conhecimento'),nl,
    write('2. Consultas à base de conhecimento'),nl,
    write('3. Base de dados'),nl,
    write('4. Mais informações'),nl,
    write('5. Sair'),nl,
    ler_opcao(Opcao).

ler_opcao(Opcao):-
    get_single_char(C),
    put_code(C),
    number_codes(Opcao, [C]),
    opcao_valida(Opcao),nl.

ler_opcao(Opcao):-
    nl, write('*** Opcao inválida. Tente outra vez: '),
    ler_opcao(Opcao).

opcao_valida(Opcao):-
    Opcao >=1,
    Opcao =<5.



