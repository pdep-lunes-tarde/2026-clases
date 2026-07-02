% Punto 1: empleados

% Una empresa está buscando candidatos para varios de sus sectores. Se sabe que:

%     Roque es contador, honesto y ambicioso.
%     Ana es ingeniera y honesta, pero no es ambiciosa.
%     Cecilia es abogada.

contador(roque).

honesto(roque).
honesto(ana).

ambicioso(roque).

ingeniero(ana).

abogado(cecilia).

% a) Escribí una base de conocimiento que permita consultarla de la siguiente forma:

% ? honesto(ana).
% true.

% Ahora queremos saber qué empleados pueden servir para un sector dado.

% Sabiendo lo que declaramos en el punto a) y además que Roque y Cecilia trabajaron en la utn,

trabajo_en(roque, utn).
trabajo_en(cecilia, utn).


% b) desarrollá un predicado puedeAndar/2 que relaciona a un sector con un empleado si este puede trabajar allí. Considerar que:

% puede_andar(Sector, Empleado)

sector(contaduria).
sector(ventas).

puede_andar(contaduria, Alguien):-
    contador(Alguien),
    honesto(Alguien).
puede_andar(ventas, Alguien):-
    ambicioso(Alguien),
    tiene_experiencia(Alguien).
puede_andar(ventas, lucia).

tiene_experiencia(Alguien):-
    trabajo_en(Alguien, _).

%     en contaduria solo pueden trabajar contadores honestos
%     en ventas solo pueden trabajar ambiciosos que tienen experiencia (gente que haya trabajado en algun lugar antes)
%     y lucia siempre puede trabajar en ventas

:- begin_tests(tp1).

:- end_tests(tp1).