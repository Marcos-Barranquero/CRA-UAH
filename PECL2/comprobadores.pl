:-['draw.pl'].
:-['datos.pl'].

% Archivo con los comprobadores de concordancia %

% Comprobador de concordancia entre generos %
comprobar_genero([G1, G2|TG]):-
    concordancia_generos(G1, G2),   % Compruebo la concordancia entre los dos primeros de la lista
    comprobar_genero([G2|TG]).    % Llamo a recursion con el segundo de la lista y el resto de la lista

comprobar_genero([_|[]]).

concordancia_generos(Gen1, Gen2):-Gen1=Gen2.
concordancia_generos(Gen1, Gen2):-Gen1\=Gen2,writeln('El genero no concuerda.'), fail.

% Comprobador de concordancia entre numeros %
comprobar_numero([N1, N2|TN]):-
    concordancia_numeros(N1, N2),  % Compruebo la concordancia entre los dos primeros de la lista
    comprobar_numero([N2|TN]).   % Llamo a recursion con el segundo de la lista y el resto de la lista

comprobar_numero([_|[]]).

concordancia_numeros(Num1, Num2):-Num1=Num2.
concordancia_numeros(Num1, Num2):-Num1\=Num2,writeln('El numero no concuerda.'), fail.

% Comprobador de concordancia entre las personas del S.Nom y el S.Verb %
concordancia_sujeto_verbo_persona(PersonaN, PersonaV):-PersonaN=PersonaV.
concordancia_sujeto_verbo_persona(PersonaN, PersonaV):-PersonaN\=PersonaV, fail.

% Comprobador de concordancia entre el numero de la persona del S.Nom y del S.Verb %
concordancia_sujeto_verbo_numero(NumeroN, NumeroV):-NumeroN=NumeroV.
concordancia_sujeto_verbo_numero(NumeroN, NumeroV):-NumeroN\=NumeroV, fail.


% ------------------------------------------------------------------------------ %
% Dada una frase, itera sobre esta añadiendo verbos o comas a una tercera lista. % 
% Después, se ve la longitud de dicha lista para poder optimizar las pruebas.    %
% ------------------------------------------------------------------------------ %

numero_verbos(Frase, Verbos):- num_ver_aux(Frase, [],Verbos).

num_ver_aux([Cabeza|Resto], ListaVerbos,Verbos):-
    v(Cabeza,_,_) -> 
        num_ver_aux(Resto, [Cabeza|ListaVerbos], Verbos);
        num_ver_aux(Resto, ListaVerbos, Verbos).


num_ver_aux([], V,V). 

% Contador de comas (oraciones explicativas)
numero_comas(Frase, Comas):- num_comas_aux(Frase, [], Comas).

num_comas_aux([Cabeza|Resto], ListaComas, Comas):-
    com(Cabeza) ->
        num_comas_aux(Resto, [Cabeza|ListaComas], Comas);
        num_comas_aux(Resto, ListaComas, Comas).

num_comas_aux([],C,C).