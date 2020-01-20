% Verbos:
verbo(v(X),Persona,Numero) --> [X],{v(X,Persona,Numero)}, !.
v(ama, 3, s).
v(come, 3, s).
v(comen, 3, p).
v(estudia, 3, s).
v(hace, 3, s).
v(canta, 3, s).
v(alzo, 3, s).
v(esta, 3, s).
v(es, 3, s).
v(era, 1, s).
v(era, 3, s).
v(habla, 3, s).
v(depende, 3, s).
v(vimos, 1, p).
v(recoge, 3, s).
v(toma, 3, s).
v(compre, 3, s).
v(beben, 3, p).
v(salta, 3, s).
v(sonrie, 3, s).
v(sirve, 3, s).
v(cazo, 3, s).

% Nombres:
nombre(n(X), Gen, Num, Persona) --> [X],{n(X,Gen, Num, Persona)}.
n(hombre, m, s, 3).
n(mujer, f, s, 3).
n(gato, m, s, 3).
n(raton, m, s, 3).
n(ratones, m, p, 3).
n(alumno, m, s, 3).
n(alumna, f, s, 3).
n(manzana, f, s, 3).
n(manzanas, f, p, 3).
n(patatas, f, p, 3).
n(tenedor, m, s, 3).
n(cuchillo, m, s, 3).
n(juan, m, s, 3).
n(maria, f, s, 3).
n(el, m, s, 3).
n(ella, f, s, 3).
n(practica, f, s, 3).
n(canario, m, s, 3).
n(paloma, f, s, 3).
n(vuelo, m, s, 3).
n(madrid, _, s, 3).
n(reflejos, m, p, 3).
n(esperanza, f, s, 3).
n(vida, f, s, 3).
n(nino, m, s, 3).
n(lugar, m, s, 3).
n(universidad, f, s, 3).
n(nacimiento, m, s, 3).
n(profesor, m, s, 3).
n(mesa, f, s, 3).
n(cafe, m, s, 3).
n(pantalon, m, s, 3).
n(corbata, f, s, 3).
n(hector, m, s, 3).
n(cerveza, f, s, 3).
n(irene, f, s, 3).
n(procesador,m,s,3).
n(textos, m, p, 3).
n(herramienta, f, s, 3).
n(documentos, m, p, 3).
n(escribir, m, s, 3).


% Determinantes:
determinante(det(X), Gen, Num) --> [X],{det(X, Gen, Num)}.
det(el, m, s).
det(la, f, s).
det(los, m, p).
det(un, m, s).
det(uno, m, s).
det(unos, m, p).
det(las, f, p).
det(una, f, s).
det(unas, f, p).
% Posesivos
det(mi, _, s).
det(tu, _, s).
det(su, _, _).
det(nuestro, m, p).
det(nuestra, f, p).
det(vuestro, m, p).
det(vuestra, f, p).

% Adjetivos:
adjetivo(adj(X), Gen, Num) --> [X], {adj(X, Gen, Num)}.
adj(grande, _, s).
adj(roja, f, s).
adj(rojas, f, p).
adj(negro, m, s).
adj(negros, m, p).
adj(blanca, f, s).
adj(moreno, m, s).
adj(morena, f, s).
adj(alta, f, s).
adj(alto, m, s).
adj(delicado, m, s).
adj(fritas, f, p).
adj(alegre, _, s).
adj(potente, _, s).
adj(gris, m, s).

% Preposiciones:
preposicion(prep(X)) --> [X],{prep(X)}.
prep(a).
prep(ante).
prep(bajo).
prep(cabe).
prep(con).
prep(contra).
prep(de).
prep(desde).
prep(en).
prep(entre).
prep(hacia).
prep(hasta).
prep(para).
prep(por).
prep(segun).
prep(sin).
prep(so).
prep(sobre).
prep(tras).
prep(durante).
prep(mediante).

% Conjunciones:
conjuncion(conj(X)) --> [X],{conj(X)}.
conj(y).
conj(que).
conj(e).
conj(o).
conj(u).

% Adverbios:
adverbio(adv(X)) --> [X], {adv(X)}.
adv(muy).
adv(claramente).
adv(lejos).
adv(mucho).
adv(lento).
adv(solamente).
adv(bastante).

%Que, para formar ciertas frases especiales:
que(q(X)) --> [X], {q(X)}.
q(que).

% Nexos:
nexo(nx(X)) --> [X], {nx(X)}.
nx(y).
nx(pero).
nx(que).
nx(mientras).

% Coma:
coma(com(X)) --> [X],{com(X)}.
com(',').