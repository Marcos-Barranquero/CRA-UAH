% Se carga el fichero que guarda las peliculas
:-['peliculas.pl'].

% Recupera el archivo peliculas.pl en forma de lista para poder trabajar con el facilmente
listaPeliculas(Lista_peliculas):-
    % Abre el archivo en modo lectura 
    open('peliculas.pl', read, Id_archivo),
    % llama a la funcion auxiliar leerArchivo y almacena los contenidos del archivo en la variable Lista_peliculas
    leerArchivo(Id_archivo, Lista_peliculas),
    % cierra el archivo
    close(Id_archivo).

% Funcion auxiliar que se encarga de leer el archivo
leerArchivo(Id_archivo, Lista):-
    % Leo la primera línea del archivo, guardándola en Linea
    read_term(Id_archivo, Linea, []), 
    % Si Linea es el final del archivo, L es una lista vacia
    (   Linea = end_of_file -> Lista = [];
        % En caso contrario, pongo Linea en la cabeza de la lista
        % y llamo recursivamente a la funcion con el resto del archivo
        Lista = [Linea|Resto], leerArchivo(Id_archivo, Resto)
    ).


% Función que muestra el menú por la pantalla.
menu:-
    writeln('----------------------------'),
    writeln('-----Akinator peliculas-----'),
    writeln('----------------------------'),
    nl, nl,
    writeln('Deseas jugar? (si/no): '),
    read(Respuesta_usuario),
    verificar(Respuesta_usuario).
    
    % Si el usuario introduce no, se sale del juego.
    verificar(no):-
        nl, writeln('Hasta luego!'), nl, halt.

    % Si el usuario introduce si, se juega una nueva partida.
    verificar(si):- 
        % se muestran instrucciones por pantalla.
        nl,
        writeln('Para jugar, introduce si o no, sin comillas: '),
        %writeln('s = si'), writeln('n = no'), nl,
        % Se carga la lista de todas las películas
        listaPeliculas(Peliculas),
        % Y se comienza a hacer preguntas.
        preguntar(Peliculas, Candidatos, Caracteristicas),
        % 
        conclusion(Candidatos, Caracteristicas),
         menu.

preguntas([
    % Décadas
    pregunta(decada(1950), decada(_), 'Es de la decada de los 50s?: '),
    pregunta(decada(1960), decada(_), 'Es de la decada de los 60s?: '),
    pregunta(decada(1970), decada(_), 'Es de la decada de los 70s?: '),
    pregunta(decada(1980), decada(_), 'Es de la decada de los 80s?: '),
    pregunta(decada(1990), decada(_), 'Es de la decada de los 90s?: '),
    pregunta(decada(2000), decada(_), 'Es de la decada de los 00s?: '),
    pregunta(decada(2010), decada(_), 'Es de la decada de los 10s?: '),

    % Países
    pregunta(pais('EEUU'), pais(_), 'La pelicula es de EEUU?'),
    pregunta(pais('UK'), pais(_), 'La pelicula es de UK?'),
    pregunta(pais('New Zealand'), pais(_), 'La pelicula es de New Zealand?'),
    pregunta(pais('Italia'), pais(_), 'La pelicula es de Italia?'),
    pregunta(pais('Espana'), pais(_), 'La pelicula es de Espana?'),
    pregunta(pais('Irlanda'), pais(_), 'La pelicula es de Irlanda?'),
    pregunta(pais('Japon'), pais(_), 'La pelicula es de Japon?'),
    
    % Género
    pregunta(genero(drama), genero(_), 'Es de drama?: '),
    pregunta(genero(accion), genero(_), 'Es de accion?: '),
    pregunta(genero(ciencia_ficcion), genero(_), 'Es de ciencia ficcion?: '),
    pregunta(genero(animacion), genero(_), 'Es de animacion?: '),
    pregunta(genero(fantasia), genero(_), 'Es de fantasia?: '),
    pregunta(genero(comedia), genero(_), 'Es una comedia?: '),
    pregunta(genero(intriga), genero(_), 'Es de intriga?: '),
    pregunta(genero(crimen), genero(_), 'Es de crimen?: '),
    pregunta(genero(terror), genero(_), 'Es de terror?: '),
    pregunta(genero(aventuras), genero(_), 'Es de aventuras?: '),

    % Mundo
    pregunta(mundo(ficcion), mundo(_), 'Esta ambientada en un mundo ficticio? (o mundo real con elementos de ficcion): '),
    pregunta(mundo(real), mundo(_), 'Esta ambientada estrictamente en el mundo real?: '),

    % Hay guerra
    pregunta(guerra, guerra, 'Hay alguna guerra en la pelicula?: '),
    
    % Hay nazis
    pregunta(nazis, nazis, 'Hay algun nazi en la pelicula?: '),

    % Es cortita
    pregunta(corta, corta, 'La pelicula dura menos de 2 horas?: '),

    % Protagonista
    pregunta(protagonista(hombre), protagonista(_), 'El protagonista es un hombre?: '),
    pregunta(protagonista(mujer), protagonista(_), 'La protagonista es una mujer?: '),

    % Saga
    pregunta(saga, saga, 'La pelicula es parte de una saga?: '),

    % Ambientación
    pregunta(ambientacion(pasado), ambientacion(_), 'Esta ambientada en el pasado (anterior a 1960)?: '),
    pregunta(ambientacion(contemporaneo), ambientacion(_), 'Esta ambientada en una epoca contemporanea? (desde 1960): '),
    pregunta(ambientacion(futuro), ambientacion(_), 'Esta ambientada en el futuro?: '),

    % Productora
    pregunta(productora('Pixar'), productora(_), 'Es de la productora Pixar?: '),
    pregunta(productora('Warner'), productora(_), 'Es de la productora Warner?: '),
    pregunta(productora('Paramount'), productora(_), 'Es de la productora Paramount?: '),
    pregunta(productora('Disney'), productora(_), 'Es de la productora Disney?: '),
    pregunta(productora('Wingnut Films'), productora(_), 'Es de la productora Wingnut Films?: '),
    pregunta(productora('DreamWorks'), productora(_), 'Es de la productora DreamWorks?: '),
    pregunta(productora('Metro'), productora(_), 'Es de la productora Metro?: '),
    pregunta(productora('Melampo'), productora(_), 'Es de la productora Melampo?: '),
    pregunta(productora('New Line'), productora(_), 'Es de la productora New Line?: '),
    pregunta(productora('Coproduccion'), productora(_), 'Es una coproduccion?: '),
    pregunta(productora('Miramax'), productora(_), 'Es de la productora Miramax?: '),
    pregunta(productora('Zoetrope'), productora(_), 'Es de la productora Zoetrope?: '),
    pregunta(productora('Orion'), productora(_), 'Es de la productora Orion?: '),
    pregunta(productora('Oz'), productora(_), 'Es de la productora Oz?: '),
    pregunta(productora('Fox'), productora(_), 'Es de la productora Fox?: '),
    pregunta(productora('Cartel'), productora(_), 'Es de la productora Cartel?: '),
    pregunta(productora('Sogetel'), productora(_), 'Es de la productora Sogetel?: ')
]).

% recupera la lista de preguntas disponibles y llama a preguntar/5
preguntar(Candidatos, Candidatos_out, Caracteristicas_out):- 
    % Tomo las preguntas
    preguntas(ListaPreguntas),
    % Y llamo a preguntar/5.
    preguntar(ListaPreguntas, Candidatos, [], Candidatos_out, Caracteristicas_out).

% llama a la funcion auxiliar donde se hacen las preguntas y se llama a si misma con el resto de preguntas para recorrer toda la lista
preguntar([Pregunta|Resto], Candidatos_in, Caracteristicas, Candidatos_out, Caracteristicas_out):-
    realizar_pregunta(Pregunta, Candidatos_in, Caracteristicas, Candidatos_aux, Caracteristicas_aux), 
    preguntar(Resto, Candidatos_aux, Caracteristicas_aux, Candidatos_out, Caracteristicas_out).

% Funcion de gestion de la lista vacia, que ocurre cuando ya hemos agotado las preguntas
preguntar([], Candidatos, Caracteristicas, Candidatos, Caracteristicas).

% Si solo queda 1 peli candidata, se intenta adivinarla. 
realizar_pregunta(Pregunta, [P|[]], Caracteristicas, Candidatos_out, Caracteristicas_out):-
    intentaAdivinar([P|[]]),
    % Si no era esa, se sigue preguntando para recolectar info. 
    realizar_pregunta(Pregunta, [], Caracteristicas, Candidatos_out, Caracteristicas_out).

% Funcion que hace las preguntas y llama a las funciones de filtro segun la respuesta
realizar_pregunta(Pregunta, Candidatos, Caracteristicas, Candidatos_out, Caracteristicas_out):-
    pregunta(Dato, Repetido, Mensaje) = Pregunta,                                                                     % Convierto el elemento de la lista de preguntas a una pregunta
    (memberchk(Repetido, Caracteristicas) -> Candidatos_out = Candidatos, Caracteristicas_out = Caracteristicas;                 % Si ya hay una respuesta para la pregunta que estamos evaluando, la saltamos 
        writeln(Mensaje), read(Input),                                                                                             % Si no, sacamos el mensaje por pantalla y esperamos input
                        (Input = si -> tiene(Candidatos, Dato, Candidatos_out), Caracteristicas_out = [Dato|Caracteristicas];    % Si la respuesta es si, filtramos por las peliculas que cumplen la condicion
                            Input = no -> no_tiene(Candidatos, Dato, Candidatos_out), Caracteristicas_out = Caracteristicas;        % Si la respuesta es no, filtramos por las peliculas que no cumplen la condicion
                            realizar_pregunta(Pregunta, Candidatos, Caracteristicas, Candidatos_out, Caracteristicas_out)         % Si la respuesta no es valida, se vuelve a formular la misma pregunta
                        )
    ).

intentaAdivinar(Candidatos):-
    Candidatos = [pelicula(Titulo, _)|[]],
    %Pelicula = pelicula(Titulo|_),
    write('Tu pelicula es '), write(Titulo), write('?\n'),
        read(Input),
        (
            Input = si -> writeln('Gracias por jugar.'), nl, menu;     % Si la respuesta es si, gana el programa, se salta al menú.
            Input = no -> writeln('Habia que intentarlo. ')     % Si no, se sigue preguntando características para almacenar la película. 
        ).
    
% Si la lista de candidatos esta vacia, añadimos una nueva pelicula
conclusion([], Caracteristicas):-
    anadirPelicula(Caracteristicas).

conclusion(Candidatos, Caracteristicas):-                       
    Candidatos = [pelicula(Titulo, _)|Resto],                   % Coge la primera pelicula de la lista de candidatos y almacena el resto por si acaso
    write('Tu pelicula es '), write(Titulo), write('?\n'),
    read(Input),
        (
            Input = si -> writeln('Gracias por jugar.'), nl;     % Si la respuesta es si, gana el programa
            Input = no -> conclusion(Resto, Caracteristicas)     % Si no, llama a recursion hasta que la lista este vacia
        ).

% Añade una nueva película al documento, con las características respondidas. 
anadirPelicula(Caracteristicas):-
    nl, writeln('No conozco esa pelicula, introduce el titulo para guardarla(entre comillas simples ''''): '),
    read(Input),
    (\+ pelicula(Input, _) -> 
        assertz(pelicula(Input, Caracteristicas)),
        tell('peliculas.pl'),
        listing(pelicula),
        told
    ).

% FUNCIONES DE FILTRO
no_tiene(Peliculas_in, Dato, Peliculas_out):-
    % Llamo a la fun. aux con lista vacía. 
    no_tiene_aux(Peliculas_in, Dato, [], Peliculas_out).

no_tiene_aux([Pelicula|Otras], Dato, Peliculas_aux, Peliculas_out):-
    % Si la película contiene el dato y no está en la lista aux.
    (
        % Tomo película
        pelicula(_, Caracteristicas) = Pelicula,
        % Compruebo que NO tiene el dato
        \+ memberchk(Dato, Caracteristicas),
        % Y que no la he tomado previamente
        \+ memberchk(Pelicula, Peliculas_aux) 
        % Entonces
        ->
            % La añado
            Peliculas_new_aux = [Pelicula|Peliculas_aux],
            % y continúo verificando el resto de pelis
            no_tiene_aux(Otras, Dato, Peliculas_new_aux, Peliculas_out)
    ;
        %Si la película tiene el dato, me la salto y continúo:
        no_tiene_aux(Otras, Dato, Peliculas_aux, Peliculas_out)
    ).

no_tiene_aux([], _, Peliculas_aux, Peliculas_aux).

tiene(Peliculas_in, Dato, Peliculas_out):-
    % Llamo a la fun. aux con lista vacía. 
    tiene_aux(Peliculas_in, Dato, [], Peliculas_out).

tiene_aux([Pelicula|Otras], Dato, Peliculas_aux, Peliculas_out):-
    % Si la película contiene el dato y no está en la lista aux.
    (
        % Tomo película
        pelicula(_, Caracteristicas) = Pelicula,
        % Compruebo que tiene el dato
        memberchk(Dato, Caracteristicas),
        % Y que no la he tomado previamente
        \+ memberchk(Pelicula, Peliculas_aux) 
        % Entonces
        ->
            % La añado
            Peliculas_new_aux = [Pelicula|Peliculas_aux],
            % y continúo verificando el resto de pelis
            tiene_aux(Otras, Dato, Peliculas_new_aux, Peliculas_out)
    ;
        % Si la película no tiene el dato, me la salto y continúo:
        tiene_aux(Otras, Dato, Peliculas_aux, Peliculas_out)
    ).

tiene_aux([], _, Peliculas_aux, Peliculas_aux).