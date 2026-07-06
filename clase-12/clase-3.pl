estaEn(argentina, grupoJ).
estaEn(algeria, grupoJ).
estaEn(austria, grupoJ).
estaEn(jordania, grupoJ).
estaEn(mexico, grupoA).
estaEn(sudafrica, grupoA).
estaEn(coreaDelSur, grupoA).
estaEn(republicaCheca, grupoA).

estaEnElMundial(Pais):-
    estaEn(Pais, _).

juegaContra(UnPais, OtroPais):-
    estaEn(UnPais, Grupo),
    estaEn(OtroPais, Grupo),
    UnPais \= OtroPais.

hinchadaBancaA(Pais, Pais):-
    estaEnElMundial(Pais).
hinchadaBancaA(bangladesh, argentina).
hinchadaBancaA(india, Pais):-
    estaEnElMundial(Pais).

% Predicado nuevo
% partido(UnPais, OtroPais, GolesDeUnPais, GolesDeOtroPais).

goles_recibidos(Pais, CantidadGoles):-
    partido(Pais, _, _, CantidadGoles).
goles_recibidos(Pais, CantidadGoles):-
    partido(_, Pais, CantidadGoles, _).

le_hicieron_algun_gol(Pais):-
    goles_recibidos(Pais, Cantidad),
    Cantidad > 0.

tiene_valla_invicta(Pais):-
    goles_recibidos(Pais, _),
    % not(
    %     (goles_recibidos(Pais, Cantidad), Cantidad > 0)
    % ).
    not(le_hicieron_algun_gol(Pais)).


% Se podria tambien hacer esto un poco mas generico por si
% queremos hacer varios predicados que pregunten sobre resultados
% de un pais
resultado_partido(Pais, OtroPais, GolesPais, GolesOtroPais):-
    partido(Pais, OtroPais, GolesPais, GolesOtroPais).
resultado_partido(Pais, OtroPais, GolesPais, GolesOtroPais):-
    partido(OtroPais, Pais, GolesOtroPais, GolesPais).

diferencia_de_goles(UnPais, OtroPais, Diferencia):-
    resultado_partido(UnPais, OtroPais, GolesDeUnPais, GolesDeOtroPais),
    Diferencia = GolesDeUnPais - GolesDeOtroPais.

ganador(Ganador, OtroPais, Ganador):-
    diferencia_de_goles(Ganador, OtroPais, Diferencia),
    Diferencia > 0.
ganador(OtroPais, Ganador, Ganador):-
    diferencia_de_goles(Ganador, OtroPais, Diferencia),
    Diferencia > 0.

% Grupo J
partido(argentina, algeria, 3, 0).
partido(austria, jordania, 3, 1).
partido(argentina, austria, 2, 0).
partido(jordania, algeria, 1, 2).
partido(argentina, jordania, 3, 1).
partido(austria, algeria, 3, 3).

% Grupo A
partido(mexico, sudafrica, 2, 0).
partido(coreaDelSur, republicaCheca, 2, 1).
partido(republicaCheca, sudafrica, 1, 1).
partido(mexico, coreaDelSur, 1, 0).
partido(republicaCheca, mexico, 0, 3).
partido(sudafrica, coreaDelSur, 1, 0).

% Queremos saber si un equipo tuvo valla invicta, que se cumple si no hubo
% ningún partido en el que le metieran un gol.

% Primero que nada, estaria bueno poder preguntar para un pais
% cuales fueron los goles en contra que tuvo por partido.
