estaEn(mexico, grupoA).
estaEn(sudafrica, grupoA).
estaEn(coreaDelSur, grupoA).
estaEn(republicaCheca, grupoA).

estaEn(canada, grupoB).
estaEn(bosnia, grupoB).
estaEn(qatar, grupoB).
estaEn(suiza, grupoB).

estaEn(brasil, grupoC).
estaEn(marruecos, grupoC).
estaEn(haiti, grupoC).
estaEn(escocia, grupoC).

estaEn(estadosUnidos, grupoD).
estaEn(paraguay, grupoD).
estaEn(australia, grupoD).
estaEn(turquia, grupoD).

estaEn(alemania, grupoE).
estaEn(curazao, grupoE).
estaEn(costaDeMarfil, grupoE).
estaEn(ecuador, grupoE).

estaEn(paisesBajos, grupoF).
estaEn(japon, grupoF).
estaEn(suecia, grupoF).
estaEn(tunez, grupoF).

estaEn(belgica, grupoG).
estaEn(egipto, grupoG).
estaEn(iran, grupoG).
estaEn(nuevaZelanda, grupoG).

estaEn(espana, grupoH).
estaEn(caboVerde, grupoH).
estaEn(arabiaSaudita, grupoH).
estaEn(uruguay, grupoH).

estaEn(francia, grupoI).
estaEn(senegal, grupoI).
estaEn(iraq, grupoI).
estaEn(noruega, grupoI).

estaEn(argentina, grupoJ).
estaEn(argelia, grupoJ).
estaEn(austria, grupoJ).
estaEn(jordania, grupoJ).

estaEn(portugal, grupoK).
estaEn(congoRD, grupoK).
estaEn(uzbekistan, grupoK).
estaEn(colombia, grupoK).

estaEn(inglaterra, grupoL).
estaEn(croacia, grupoL).
estaEn(ghana, grupoL).
estaEn(panama, grupoL).

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
hinchadaBancaA(Pais, caboVerde):-
    estaEnElMundial(Pais).

% Predicado nuevo
% partido(UnPais, OtroPais, GolesDeUnPais, GolesDeOtroPais).

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

% Grupo J
partido(argentina, argelia, 3, 0).
partido(austria, jordania, 3, 1).
partido(argentina, austria, 2, 0).
partido(jordania, argelia, 1, 2).
partido(argentina, jordania, 3, 1).
partido(austria, argelia, 3, 3).

% Grupo K
partido(portugal, congoRD, 2, 0).
partido(uzbekistan, colombia, 1, 1).
partido(portugal, uzbekistan, 3, 0).
partido(congoRD, colombia, 2, 1).
partido(portugal, colombia, 4, 0).
partido(congoRD, uzbekistan, 1, 0).

% Grupo L
partido(inglaterra, croacia, 1, 1).
partido(ghana, panama, 2, 2).
partido(inglaterra, ghana, 2, 0).
partido(croacia, panama, 3, 0).
partido(inglaterra, panama, 1, 0).
partido(croacia, ghana, 0, 1).

% Grupo A
partido(mexico, sudafrica, 2, 0).
partido(coreaDelSur, republicaCheca, 2, 1).
partido(republicaCheca, sudafrica, 1, 1).
partido(mexico, coreaDelSur, 1, 0).
partido(republicaCheca, mexico, 0, 3).
partido(sudafrica, coreaDelSur, 1, 0).

% Grupo B
partido(canada, bosnia, 2, 0).
partido(qatar, suiza, 1, 0).
partido(canada, qatar, 1, 0).
partido(bosnia, suiza, 3, 3).
partido(canada, suiza, 4, 1).
partido(bosnia, qatar, 1, 1).

% Grupo C
partido(brasil, marruecos, 2, 1).
partido(haiti, escocia, 0, 1).
partido(brasil, haiti, 1, 0).
partido(marruecos, escocia, 1, 1).
partido(brasil, escocia, 4, 0).
partido(marruecos, haiti, 2, 0).

% Grupo D
partido(estadosUnidos, paraguay, 6, 2).
partido(australia, turquia, 1, 1).
partido(estadosUnidos, australia, 0, 0).
partido(paraguay, turquia, 2, 0).
partido(estadosUnidos, turquia, 3, 0).
partido(paraguay, australia, 0, 1).

% Grupo E
partido(alemania, curazao, 7, 0).
partido(costaDeMarfil, ecuador, 1, 2).
partido(alemania, costaDeMarfil, 1, 1).
partido(curazao, ecuador, 0, 1).
partido(alemania, ecuador, 1, 2).
partido(costaDeMarfil, curazao, 4, 2).

% Grupo F
partido(paisesBajos, japon, 1, 0).
partido(suecia, tunez, 0, 0).
partido(paisesBajos, suecia, 0, 2).
partido(japon, tunez, 1, 4).
partido(paisesBajos, tunez, 0, 0).
partido(japon, suecia, 1, 2).

% Grupo G
partido(belgica, egipto, 0, 2).
partido(iran, nuevaZelanda, 1, 1).
partido(belgica, iran, 0, 2).
partido(egipto, nuevaZelanda, 2, 1).
partido(belgica, nuevaZelanda, 1, 0).
partido(egipto, iran, 3, 2).

% Grupo H
partido(espana, caboVerde, 0, 0).
partido(arabiaSaudita, uruguay, 0, 2).
partido(espana, arabiaSaudita, 2, 0).
partido(caboVerde, uruguay, 2, 2).
partido(espana, uruguay, 3, 1).
partido(caboVerde, arabiaSaudita, 2, 1).

% Grupo I
partido(francia, senegal, 1, 2).
partido(iraq, noruega, 0, 1).
partido(francia, iraq, 2, 0).
partido(senegal, noruega, 3, 1).
partido(francia, noruega, 0, 2).
partido(senegal, iraq, 1, 1).

partido(alemania, paraguay, fue_a_penales(1, 1, 3, 4)).
partido(UnPais, OtroPais, termino_en_90(GolesUnPais, GolesOtroPais)):-
    partido(UnPais, OtroPais, GolesUnPais, GolesOtroPais).

% Queremos saber si un equipo tuvo valla invicta, que se cumple si no hubo
% ningún partido en el que le metieran un gol.
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


% Primero que nada, estaria bueno poder preguntar para un pais
% cuales fueron los goles en contra que tuvo por partido.

ganador(Ganador, OtroPais, Ganador):-
    diferencia_de_goles(Ganador, OtroPais, Diferencia),
    Diferencia > 0.
ganador(OtroPais, Ganador, Ganador):-
    diferencia_de_goles(Ganador, OtroPais, Diferencia),
    Diferencia > 0.
ganador(Ganador, OtroPais, Ganador):-
    partido(Ganador, OtroPais, fue_a_penales(_, _, GolesUnPais, GolesOtroPais)),
    GolesUnPais > GolesOtroPais.
ganador(UnPais, Ganador, Ganador):-
    partido(UnPais, Ganador, fue_a_penales(_, _, GolesUnPais, GolesOtroPais)),
    GolesUnPais < GolesOtroPais.

