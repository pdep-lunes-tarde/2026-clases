% Registramos las características de las lechuzas de la zona
% (nombre, sospechosidad y nobleza) con un predicado lechuza/3.

% lechuza(Lechuza, Sospechosidad, Nobleza)
lechuza(duo, 10, 2).
lechuza(prolog, 10, 51).
lechuza(noctowl, 20, 42).
lechuza(coo, 80, 55).

% Necesitamos saber:

% ¿Qué tan violenta es una lechuza?
% Se calcula como 5 * sospechosidad + 42 / nobleza.
% Si una lechuza es vengativa. Lo es si su violencia es mayor a 100.
% Si una lechuza es mafiosa, que se cumple si no es buena gente o su sospechosidad es al menos 75. Decimos que es buena gente si no es vengativa y su nobleza es mayor a 50.

:- begin_tests(lechuzas).

:- end_tests(lechuzas).