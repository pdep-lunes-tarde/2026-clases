% SOLUCION EN PARADIGMA LOGICO

% Queremos poder contesar algunas cosas sobre
% los países que juegan la fase de grupos del mundial como, ¿es cierto que Algeria está en el grupo J?


% En el grupo J están Argentina, Algeria, Austria y Jordania.
% En el grupo A están México, Sudáfrica, Corea del Sur y República Checa.
% Chile no está en ningún grupo.

% estaEn(Pais, Grupo)
estaEn(argentina, grupoJ).
estaEn(algeria, grupoJ).
estaEn(austria, grupoJ).
estaEn(jordania, grupoJ).
estaEn(mexico, grupoA).
estaEn(sudafrica, grupoA).
estaEn(coreaDelSur, grupoA).
estaEn(republicaCheca, grupoA).

% ¿Y cómo podríamos preguntar en qué grupo está Sudáfrica?
% Ya podemos hacerlo con:
% estaEn(sudafrica, Grupo).

% ¿Y cómo podríamos preguntar qué paises están en el grupo A?
% Ya podemos hacerlo con:
% estaEn(Pais, grupoA).

% ¿Cómo podríamos preguntar si un país está en el mundial?, esto es verdad si pertenece a algún grupo.
% ya podemos hacerlo con:
% estaEn(sudafrica, _).

estaEnElMundial(Pais):-
    estaEn(Pais, _).

juegaContra(UnPais, OtroPais):-
    estaEn(UnPais, Grupo),
    estaEn(OtroPais, Grupo),
    UnPais \= OtroPais.
% juegaContra(argentina, algeria).
% UnPais = argentina <- unificación / ligar una variable.
% OtroPais = algeria
% estaEn(argentina, Grupo), <- se evalua esta consulta, y como resultado se liga:
% Grupo = grupoJ.
% estaEn(algeria, grupoJ).
% ^^ como esta consulta individual es verdadera, la consulta juegaContra(argentina, algeria)
% da true.

% juegaContra(mexico, jordania).
% UnPais = mexico
% OtroPais = jordania
% estaEn(mexico, Grupo),
% Grupo = grupoA
% estaEn(jordania, grupoA).
% como esta ultima consulta individual me da false, la consulta juegaContra(mexico, jordania).
% da false.

% juegaContra(UnPais, OtroPais):-
%     estaEn(UnPais, Grupo),
%     estaEn(OtroPais, Grupo),
%     UnPais \= OtroPais.

% Como se evaluaria paso por paso la siguiente consulta:
% juegaContra(argentina, Pais).
% UnPais = argentina
% OtroPais = Pais
% estaEn(argentina, Grupo)
% Grupo = grupoJ
% estaEn(Pais, grupoJ)
% Tenemos 4 posibles resultados:
% Pais = argentina ;
% Pais = algeria ;
% Pais = austria ;
% Pais = jordania.
% ¿Con cuál de ellos ligamos Pais?
% Prolog va a bifurcar en las distintas soluciones que puede encontrar.
% Queda un punto de bifurcación ahí (en Pais = ...).
% Continuamos probando con uno de ellos:
% OtroPais = argentina.
% argentina \= argentina -> false
% por esta rama, prolog no puede demostrar que la consulta sea verdadera
% Entonces, vuelve al punto de bifurcación y prueba con el siguiente:
% OtroPais = algeria
% argentina \= algeria -> true
% entonces: juegaContra(argentina, algeria) es true.
% entonces: algeria es una posible respuesta para juegaContra(argentina, Pais)
% entonces: Pais = algeria es una posible respuesta.
% Si le pido otra solución, va a volver al punto de bifurcación y probar con el siguiente:
% OtroPais = austria
% argentina \= austria -> true
% entonces: austria es una posible respuesta para juegaContra(argentina, pais)
% y lo mismo pasa con jordania

% este algoritmo de busqueda de soluciones en el cual prolog vuelve hacia
% atras cuando una rama no puede generar una solución se llama BACKTRACKING.

% Queremos saber si un pais A juega contra un pais B.
% usamos:
% juegaContra(argentina, Pais).

%%%%%%%%%%%%%%%%%%%%%%%%

% Una hinchada banca a un país si es de ese país y el país juega en el mundial.
hinchadaBancaA(Pais, Pais):- estaEnElMundial(Pais).
hinchadaBancaA(bangladesh, argentina).

% Además, hay al menos una excepción donde la hinchada de un país banca incondicionalmente a otro:
% la hinchada de bangladesh banca a argentina.


:- begin_tests(grupos).

test("un pais esta en un grupo si es parte de los paises de ese grupo", nondet):-
    estaEn(algeria, grupoJ).

test("un pais no esta en un grupo si no es parte de los paises de ese grupo"):-
    not(estaEn(mexico, grupoJ)).

test("un pais esta en el mundial si pertenece a algun grupo"):-
    estaEnElMundial(mexico).

test("un pais no esta en el mundial si no pertenece a ningun grupo"):-
    not(estaEnElMundial(italia)).

test("un pais juega contra otro si pertenecen al mismo grupo", nondet):-
    juegaContra(argentina, algeria).

test("un pais NO juega contra otro si NO pertenecen al mismo grupo", nondet):-
    not(juegaContra(sudafrica, algeria)).

test("un pais NO juega contra si mismo", nondet):-
    not(juegaContra(sudafrica, sudafrica)).

test("una hinchada banca a su pais si esta en el mundial"):-
    hinchadaBancaA(argentina, argentina).

test("una hinchada no puede bancar a su pais si no esta en el mundial"):-
    not(hinchadaBancaA(chile, chile)).

test("la hinchada de bangladesh banca a argentina"):-
    hinchadaBancaA(bangladesh, argentina).

:- end_tests(grupos).

