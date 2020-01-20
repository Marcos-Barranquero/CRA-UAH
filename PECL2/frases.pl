:-['datos.pl'].
:-['comprobadores.pl'].



% --------------------------------------------------------------------
% Este archivo contiene los diferentes constructores empleados. 
% Cuando el DCG subdivide en listas de palabras, intenta cuadrarlas
% con las distintas definiciones dadas abajo. 
% -------------------------------------------------------------------



% ----- Configuración de frases nominales: aquellas que contienen un nombre -----
% Indice
% 1.   Nom
% 2.   Det + Nom
% 3.   Adj + Nom
% 4    Nom + Adj
% 5.   Det + Nom + Adj
% 6.   Det + Adj + Nom
% 7.   Nom + Conj + Nom
% 8.   Nom + S.Prep
% 9.   Det + Nom + S.Prep
% 10.  Det + Nom + Adj + S.Prep
% 11.  Det + Adj + Nom + S.Prep
% 12.  Det + Nom + Conj + Det2 + Nom2
% 13.  Det + Nom + Conj + Det2 + Nom2 + Adj
% 14.  Pre + S.Nominal
% 15.  Oracion Explicativa


% 1 - Nom
frase_nominal(gn(Nom), Pers, NN, GN) -->
    nombre(Nom, GN, NN, Pers).

% 2 - Det + Nom
frase_nominal(gn(Det,Nom), Pers, NN, GN) --> 
    determinante(Det, GD, ND),
    nombre(Nom, GN, NN, Pers),
    {comprobar_genero([GD, GN])},
    {comprobar_numero([ND, NN])}.

% 3 - Adj + Nom
frase_nominal(gn(Adj,Nom), Pers, NN, GN) --> 
    frase_con_adjetivo(Adj, GA, NA),
    nombre(Nom, GN, NN, Pers),
    {comprobar_genero([GA, GN])},
    {comprobar_numero([NA, NN])}.

% 4 - Nom + Adj
frase_nominal(gn(Nom,Adj), Pers, NN, GN) --> 
    nombre(Nom, GN, NN, Pers),
    frase_con_adjetivo(Adj, GA, NA),
    {comprobar_genero([GA, GN])},
    {comprobar_numero([NA, NN])}.

% 5 - Det + Nom + Adj
frase_nominal(gn(Det,Nom, SAdv), Pers, NN, GN) --> 
    determinante(Det, GD, ND), 
    nombre(Nom, GN, NN, Pers), 
    frase_con_adjetivo(SAdv,GA, NA),
    {comprobar_genero([GD, GN, GA])},
    {comprobar_numero([ND, NN, NA])}.

% 6 - Det + Adj + Nom
frase_nominal(gn(Det,Adj, Nom), Pers, NN, GN) --> 
    determinante(Det, GD, ND),
    adjetivo(Adj, GA, NA),
    nombre(Nom, GN, NN, Pers),
    {comprobar_genero([GD, GA, GN])},
    {comprobar_numero([ND, NA, NN])}.

% 7 - Nom + Conj + Nom2
frase_nominal(gn(Nom,Conj,Nom2), PersonaTotal, Numero, GeneroTotal) -->
    nombre(Nom, GN, _, Pers1),
    conjuncion(Conj),
    nombre(Nom2, GN2, _, Pers2),
    {Numero = p},
    
    % Se calcula el genero resultante
    (
    {GN = GN2} -> {GeneroTotal = GN}; % Si ambos son iguales, el genero solo puede ser 1
    {GeneroTotal = m} % Si son distintos, uno de ellos es m, al ser plural, el total es m
    ),
    
    % Se calcula la persona total
    (
    {Pers1 = Pers2} -> {PersonaTotal = Pers1};
    {Pers1;Pers2 = 1} -> {PersonaTotal = 1};
    {Pers1;Pers2 = 2} -> {PersonaTotal = 2};
    {Pers1,Pers2 = 3} -> {PersonaTotal = 3}
    ).

% 8 - Nombre + S. Prep
frase_nominal(gn(Nom, SublistaNominal), Pers, NN, GN) --> 
    nombre(Nom, GN, NN, Pers),
    frase_nominal_preposicion(SublistaNominal).

% 9 - Det + Nom + S.Prep
frase_nominal(gn(Det,Nom, SublistaNominal), Pers, NN, GN) --> 
    determinante(Det, GD, ND),
    nombre(Nom, GN, NN, Pers),
    {comprobar_genero([GD, GN])},
    {comprobar_numero([ND, NN])},
    frase_nominal_preposicion(SublistaNominal).


% 10 - Det + Nom + Adj + S.Prep
frase_nominal(gn(Det,Nom, Adj, SublistaNominal), Pers, NN, GN) --> 
    determinante(Det, GD, ND),
    nombre(Nom, GN, NN, Pers),
    frase_con_adjetivo(Adj, GA, NA),
    {comprobar_genero([GD, GN, GA])},
    {comprobar_numero([ND, NN, NA])},
    frase_nominal_preposicion(SublistaNominal).


% 11 - Det + Adj + Nom + S.Prep
frase_nominal(gn(Det,Adj, Nom, SublistaNominal), Pers, NN, GN) --> 
    determinante(Det, GD, ND),
    frase_con_adjetivo(Adj, GA, NA),
    nombre(Nom, GN, NN, Pers),
    {comprobar_genero([GD, GA, GN])},
    {comprobar_numero([ND, NA, NN])},
    frase_nominal_preposicion(SublistaNominal).



% 12 - Det + Nom + Conj + Det2 + Nom2
frase_nominal(gn(Det,Nom,Conj,Det2,Nom2), PersonaTotal, Numero, GeneroTotal) -->
    determinante(Det, GD, ND),
    nombre(Nom, GN, NN, Pers1),
    {comprobar_genero([GD, GN])},
    {comprobar_numero([ND, NN])},
    
    conjuncion(Conj),

    determinante(Det2, GD2, ND2),
    nombre(Nom2, GN2, NN2, Pers2),
    {comprobar_genero([GD2, GN2])},
    {comprobar_numero([ND2, NN2])},
    
    % Al ser dos miembros en el sujeto, siempre sera plural
    {Numero = p},
    
    % Se calcula el genero resultante
    (
    {GN = GN2} -> {GeneroTotal = GN}; % Si ambos son iguales, el genero solo puede ser 1
    {GeneroTotal = m} % Si son distintos, uno de ellos es m, al ser plural, el total es m
    ),

    % Se calcula la persona total
    (
    {Pers1 = Pers2} -> {PersonaTotal = Pers1};
    {Pers1;Pers2 = 1} -> {PersonaTotal = 1};
    {Pers1;Pers2 = 2} -> {PersonaTotal = 2};
    {Pers1,Pers2 = 3} -> {PersonaTotal = 3}
    ).

% 13 - Det + Nom + Conj + Det2 + Nom2 + Adj
frase_nominal(gn(Det,Nom,Conj,Det2,Nom2,Adj), PersonaTotal, Numero, GeneroTotal) -->
    determinante(Det, GD, ND),
    nombre(Nom, GN, NN, Pers1),
    {comprobar_genero([GD, GN])},
    {comprobar_numero([ND, NN])},
    
    conjuncion(Conj),

    determinante(Det2, GD2, ND2),
    nombre(Nom2, GN2, NN2, Pers2),
    {comprobar_genero([GD2, GN2])},
    {comprobar_numero([ND2, NN2])},
    
    % Al ser dos miembros en el sujeto, siempre sera plural
    {Numero = p},
    
    % Se calcula el genero resultante
    (
      {GN = GN2} -> {GeneroTotal = GN}; % Si ambos son iguales, el genero solo puede ser 1
      {GeneroTotal = m} % Si son distintos, uno de ellos es m, al ser plural, el total es m
    ),
    
    % Se comprueba que el genero y el numero del adjetivo concuerdan con el sujeto compuesto
    frase_con_adjetivo(Adj, GA, NA),
    {comprobar_genero([GeneroTotal, GA])},
    {comprobar_numero([Numero, NA])},

    % Se calcula la persona total
    (
    {Pers1 = Pers2} -> {PersonaTotal = Pers1};
    {Pers1;Pers2 = 1} -> {PersonaTotal = 1};
    {Pers1;Pers2 = 2} -> {PersonaTotal = 2};
    {Pers1,Pers2 = 3} -> {PersonaTotal = 3}
    ).

% 14 - Pre + S.Nominal
frase_nominal_preposicion(gp(Pre, SublistaNominal)) -->
    preposicion(Pre),
    frase_nominal(SublistaNominal, _, _, _).


% 15 - Explicativa
frase_nominal_coordinada_explicativa(SublistaNominal, Coma1, Nexo, SublistaVerbal, Coma2, PersN, NN, GeneroN) -->
    frase_nominal(SublistaNominal, PersN, NN, GeneroN),
    coma(Coma1),
    nexo(Nexo),
    frase_verbal(SublistaVerbal, PersV, NV, GeneroV),
    coma(Coma2),
    {concordancia_sujeto_verbo_persona(PersN, PersV)},
    {concordancia_sujeto_verbo_numero(NN, NV)},
    {comprobar_genero([GeneroN, GeneroV])}.


% ------- Configuración de frases verbales: aquellas que contienen un verbo -------
% Índice:
% 1.   Verbo
% 2.   Verbo + S.Nom
% 3.   Verbo + Adv 
% 4.   Adv + Verbo
% 5.   Verbo + Adv + S.Nom
% 6.   Adv + Verbo + S.Nom
% 7.   Verbo + S.Prep
% 8.   Verbo + S.Prep + S.Nom
% 9.   Verbo + Adj 
% 10.  Verbo + Adj + S.Nom
% 11.  S.Nom + que + Verbo + S.Prep
% 12.  que + Verbo + S.Nom

% 1- Verbo
frase_verbal(gv(Ver), PersonaV, NumeroV,_) --> 
    verbo(Ver, PersonaV, NumeroV).

% 2- Verbo + SN
frase_verbal(gv(Ver, ParteNominal), PersonaV, NumeroV, _) -->
    verbo(Ver, PersonaV, NumeroV),
    frase_nominal(ParteNominal, _, _, _).

% 3- Verbo + Adv 
frase_verbal(gv(Ver, ParteAdverbio), PersonaV, NumeroV, _) -->
    verbo(Ver, PersonaV, NumeroV),
    frase_con_adverbio(ParteAdverbio).

% 4- Adv + verbo
frase_verbal(gv(ParteAdverbio, Ver), PersonaV, NumeroV, _) -->
    frase_con_adverbio(ParteAdverbio),
    verbo(Ver, PersonaV, NumeroV).

% 5- Verbo + Adv + SN
frase_verbal(gv(Ver, ParteAdverbio, ParteNominal), PersonaV, NumeroV, _) -->
    verbo(Ver, PersonaV, NumeroV),
    frase_con_adverbio(ParteAdverbio),
    frase_nominal(ParteNominal, _, _, _).

% 6- Adv + Verbo + SN
frase_verbal(gv(ParteAdverbio, Ver, ParteNominal), PersonaV, NumeroV, _) -->
    frase_con_adverbio(ParteAdverbio),
    verbo(Ver, PersonaV, NumeroV),
    frase_nominal(ParteNominal,_,_, _).

% 7- Verbo + S.Prep
frase_verbal(gv(Ver, SublistaNominal), PersonaV, NumeroV,_) -->
    verbo(Ver, PersonaV, NumeroV),
    frase_nominal_preposicion(SublistaNominal).

% 8- Verbo + S.Prep + F. Nominal
frase_verbal(gv(Ver, SublistaNominal, Nom), PersonaV, NumeroV,_) -->
    %13 => sirve para escribir documentos
    verbo(Ver, PersonaV, NumeroV), % sirve
    frase_nominal_preposicion(SublistaNominal), % para escribir 
    frase_nominal(Nom, _,_,_). % documentos


% 9- Verbo + Adj 
frase_verbal(gv(Ver, ParteAdverbio), PersonaV, NumeroV, GeneroAdj) -->
    verbo(Ver, PersonaV, NumeroV),
    frase_con_adjetivo(ParteAdverbio, GeneroAdj,_).

% 10- Verbo + Adj + SN
frase_verbal(gv(Ver, ParteAdjetivo, ParteNominal), PersonaV, NumeroV, GeneroAdj) -->
    verbo(Ver, PersonaV, NumeroV),
    frase_con_adjetivo(ParteAdjetivo, GeneroAdj,_),
    frase_nominal(ParteNominal, _, _, _).

% 11- Sintagma nominal + que + verbo + sintagma preposicional (oracion 11)
frase_verbal(gv(SublistaNominal, Que, Ver, SublistaPreposicion), PersonaV, NumeroV, _) -->
    frase_nominal(SublistaNominal, _, _, _),
    que(Que),
    verbo(Ver, PersonaV, NumeroV),
    frase_nominal_preposicion(SublistaPreposicion).

% 12- que + Verbo + S.Nom
frase_verbal(gv(Que, Ver, SublistaNominal), PersonaV, NumeroV, _) -->
    que(Que),
    verbo(Ver, PersonaV, NumeroV),
    frase_nominal(SublistaNominal, _, _, _).

% ------- Configuración de frases con adverbio -------
% Indice
% 1. Adverbio
% 2. Adverbio + Adverbio
% 3. Adverbio + S. Preposicional
% 4. Adverbio + Adverbio + S. Preposicional


% 1- Adv
frase_con_adverbio(gadv(Adv)) -->
    adverbio(Adv).
% 2- Adv + Adv
frase_con_adverbio(gadv(Adv, Adv2)) -->
    adverbio(Adv),
    adverbio(Adv2).
% 3- Adv + S.Pre
frase_con_adverbio(gadv(Adv, ParteNominal)) -->
    adverbio(Adv),
    frase_nominal_preposicion(ParteNominal).
% 4- Adv + S.Pre 
frase_con_adverbio(gadv(Adv, Adv2, ParteNominal)) -->
    adverbio(Adv),
    adverbio(Adv2),
    frase_nominal_preposicion(ParteNominal).


% ----- Frases con adjetivo en el sv -----
% Indice
% 1. Adj
% 2. Adverbio + Adj


% 1- Adj
frase_con_adjetivo(gadj(Adj), GA, NA) -->
    adjetivo(Adj, GA, NA).

% 2- Adv + Adj
frase_con_adjetivo(gadj(Adv, Adj), GA, NA) -->
    adverbio(Adv),
    adjetivo(Adj, GA, NA).
