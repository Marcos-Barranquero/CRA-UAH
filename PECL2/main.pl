:-['draw.pl'].
:-['frases.pl'].

% ----- Configuración de oraciones -----

% Nota: separar las comas (Ej. ' el procesador de textos , que es una herramienta...')
analiza(Oracion):-
    atomic_list_concat(L, ' ', Oracion),
    oracion(LR, L, []), draw(LR).


% Clausula que llama al tipo de oracion correspondiente en funcion del numero de verbos
oracion(ListaResuelta, Oracion, ListaSobras):-
    numero_verbos(Oracion, ListaVerbos),
    length(ListaVerbos, X),
    (
        %write("Hay "),
        %write(X),
        %writeln(" verbos. "),
        X=0 -> oracion_zero(ListaResuelta, Oracion, ListaSobras);
        X=1 -> oracion_uno(ListaResuelta,Oracion,ListaSobras);
        X=2 -> 
        numero_comas(Oracion, ListaComas),
        length(ListaComas, CuantasComas),
        (
            %write("Hay "),
            %write(X),
            %writeln(" comas. "),
            CuantasComas=0 -> oracion_dos(ListaResuelta,Oracion,ListaSobras);
            CuantasComas=2 -> oracion_explicativa(ListaResuelta, Oracion, ListaSobras)
        );
        X=3 -> oracion_tres(ListaResuelta,Oracion,ListaSobras);
        writeln('Oracion no valida para su analisis'), fail
    ).


% Oraciones simples
% Solo FN
oracion_zero(oracion(SublistaNominal)) --> 
    frase_nominal(SublistaNominal,_,_,_).

% Solo FV
oracion_uno(oracion(SublistaVerbal)) -->
    frase_verbal(SublistaVerbal,_,_,_).

% FN + FV
oracion_uno(oracion(SublistaNominal, SublistaVerbal)) --> 
    frase_nominal(SublistaNominal, PersonaN, NumeroN, GeneroN),
    frase_verbal(SublistaVerbal, PersonaV, NumeroV, GeneroV),
    {concordancia_sujeto_verbo_persona(PersonaN, PersonaV)},
    {concordancia_sujeto_verbo_numero(NumeroN, NumeroV)},
    {comprobar_genero([GeneroN, GeneroV])}.

% Oracion subordinada sin nexo
oracion_dos(oracion_subordinada(Oracion1, subor(Oracion2))) -->
    oracion_uno(Oracion1),
    oracion_uno(Oracion2).

% Oracion compuesta con nexo
oracion_dos(oracion_compuesta(oracion1(Oracion1), nexo(Nx), oracion2(Oracion2))) -->
    oracion_uno(Oracion1),
    nexo(Nx),
    oracion_uno(Oracion2).

oracion_tres(oracion_compuesta(oracion1(Oracion1), nexo(Nx1), oracion2(Oracion2), nexo(Nx2), oracion3(Oracion3))) -->
    oracion_uno(Oracion1),
    nexo(Nx1),
    oracion_uno(Oracion2),
    nexo(Nx2),
    oracion_uno(Oracion3).

% Oracion explicativa
oracion_explicativa(oc(gn(SublistaNominal, Coma1, Nexo, SublistaVerbal1, Coma2),gv(SublistaVerbal2)))-->
    frase_nominal_coordinada_explicativa(SublistaNominal, Coma1, Nexo, SublistaVerbal1, Coma2, PersonaN, NumeroN, GeneroN),
    frase_verbal(SublistaVerbal2, PersonaV, NumeroV, GeneroV),
    {concordancia_sujeto_verbo_persona(PersonaN, PersonaV)},
    {concordancia_sujeto_verbo_numero(NumeroN, NumeroV)},
    {comprobar_genero([GeneroN, GeneroV])}.




% ORACIONES DE PRUEBA %
% --- APARTADO 3 --- %
%1-  oracion(X, [el, hombre, come, una, manzana], []), draw(X).
%2-  oracion(X, [la, mujer, come, manzanas], []), draw(X).
%3-  oracion(X, [maria, come, una, manzana, roja], []), draw(X).
%4-  oracion(X, [juan, ama, a, maria], []), draw(X).
%5-  oracion(X, [el, gato, grande, come, un, raton, gris], []), draw(X).
%6-  oracion(X, [juan, estudia, en, la, universidad], []), draw(X).
%7-  oracion(X, [el, alumno, ama, la, universidad], []), draw(X).
%8-  oracion(X, [el, gato, come, ratones], []), draw(X).
%9-  oracion(X, [el, raton, que, cazo, el, gato, era, gris], []), draw(X).
%10- oracion(X, [la, universidad, es, grande], []), draw(X).

% --- ANEXO --- %
%1-  oracion(X, [el, hombre, grande, come, la, manzana, roja], []), draw(X).
%2-  oracion(X, [el, hombre, con, un, tenedor, grande, come, la, manzana, roja], []), draw(X).
%3-  oracion(X, [juan, y, maria, comen, la, manzana, roja, con, un, tenedor, y, un, cuchillo], []), draw(X).
%4-  oracion(X, [ella, hace, la, practica, de, juan], []), draw(X).
%5-  oracion(X, [el, canario, de, juan, y, maria, canta], []), draw(X).
%6-  oracion(X, [la, blanca, paloma, alzo, el, vuelo], []), draw(X).
%7-  oracion(X, [esta, muy, lejos, de, madrid], []), draw(X).
%8-  oracion(X, [el, es, lento, de, reflejos], []), draw(X).
%9-  oracion(X, [juan, habla, muy, claramente], []), draw(X).
%10- oracion(X, [la, esperanza, de, vida, de, un, nino, depende, de, su, lugar, de, nacimiento], []), draw(X).
%11- oracion(X, [el, hombre, que, vimos, en, la, universidad, era, mi, profesor], []), draw(X).
%12- oracion(X, [juan, ',', que, es, muy, delicado, ',', come, solamente, manzanas, rojas], []), draw(X).
%13- oracion(X, [el, procesador, de, textos, ',', que, es, una, herramienta, muy, potente, ',', sirve, para, escribir, documentos], []), draw(X).
%14- oracion(X, [juan, es, moreno, y, maria, es, alta], []), draw(X).
%15- oracion(X, [juan, recoge, la, mesa, mientras, maria, toma, un, cafe], []), draw(X).
%16- oracion(X, [compre, un, pantalon, y, una, corbata, negros], []), draw(X).
%17- oracion(X, [juan, y, hector, comen, patatas, fritas, y, beben, cerveza], []), draw(X).
%18- oracion(X, [irene, canta, y, salta, mientras, juan, estudia], []), draw(X).
%19- oracion(X, [irene, canta, y, salta, y, sonrie, alegre], []), draw(X).
%20- oracion(X, [el, procesador, de, textos, es, una, herramienta, muy, potente, que, sirve, para, escribir, documentos, pero, es, bastante, lento], []), draw(X).
