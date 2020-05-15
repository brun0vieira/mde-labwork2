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
    get_single_char(C), % gets a single char from input stream
    put_code(C), % write a char to the output stream -> C
    number_codes(Opcao, [C]), % converts a number to list
    opcao_valida(Opcao, A, B),nl.

ler_opcao(Opcao, A, B):-
    nl, write('*** Opcao inválida. Tente outra vez: '),
    ler_opcao(Opcao, A, B).

opcao_valida(Opcao, A, B):-
    Opcao >=A,
    Opcao =<B.

% menu_principal(1):- menu_gestao.
% menu_principal(2):- menu_consulta.
% menu_principal(3):- base_dados.
menu_principal(4):- info.
% menu_principal(5):- sair do programa

info:-
    limpar_ecra,
    write('Trabalho realizado por:'), nl,
    write('   Bruno Vieira - 50046.'), nl,
    write('   Serafim Ciobanu - 50006.'), nl, nl,
    write('Pressione \'1\' para voltar ao menu principal.'), nl,
    ler_opcao(_Opcao, 1, 1).

limpar_ecra:- write('\e[2J').

















