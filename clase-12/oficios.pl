% Migue es maestro cocinero y su herramienta es una olla essen.
% Carla es maestra alquimista y su herramienta es un mechero.
% Feche es aprendiz de mecánico y su herramienta es una llave inglesa.
% Aye es oficial alquimista y su herramienta es una piedra filosofal.

persona(migue,  profesion(maestro, cocina), ollaEsen).
persona(carla,  profesion(maestro, alquimia), mechero).
persona(feche,  profesion(aprendiz, mecanica), llaveInglesa).
persona(aye,  profesion(oficial, alquimia), piedraFilosofal).

camaradas(UnaPersona, OtraPersona):-
    persona(UnaPersona, profesion(_, Area), _),
    persona(OtraPersona, profesion(_, Area), _),
    UnaPersona \= OtraPersona.

inmediatamente_mayor(oficial, aprendiz).
inmediatamente_mayor(experto, oficial).
inmediatamente_mayor(maestro, experto).

mayor(RangoMayor, RangoMenor):-
    inmediatamente_mayor(RangoMayor, RangoMenor).
mayor(RangoMayor, RangoMenor):-
    inmediatamente_mayor(RangoMayor, RangoIntermedio),
    mayor(RangoIntermedio, RangoMenor).

tieneMasExperiencia(PersonaConMasExperiencia, PersonaConMenosExperiencia):-
    persona(PersonaConMasExperiencia, profesion(RangoMayor, _), _),
    persona(PersonaConMenosExperiencia, profesion(RangoMenor, _), _),
    mayor(RangoMayor, RangoMenor).

puedeEntrenar(Tutor, Aprendiz):-
    camaradas(Tutor, Aprendiz),
    tieneMasExperiencia(Tutor, Aprendiz).

mayor_o_igual(Rango, Rango).
mayor_o_igual(RangoMayor, RangoMenor):- mayor(RangoMayor, RangoMenor).

puedeHacer(Persona, cocinarMilanesasConPure):-
    persona(Persona, profesion(_, cocina), _).
puedeHacer(Persona, recalentarComida):-
    persona(Persona, profesion(_, cocina), _).
puedeHacer(Persona, recalentarComida):-
    persona(Persona, _, mechero).
puedeHacer(Persona, hacerMedicina(_)):-
    persona(Persona, profesion(Rango, alquimia), _),
    mayor(Rango, oficial).
puedeHacer(Persona, hacerMedicina(Gramos)):-
    persona(Persona, profesion(_, alquimia), _),
    between(1, 99, Gramos).

puedeCubrir(PersonaQueCubre, OtraPersona, Tarea):-
    puedeHacer(PersonaQueCubre, Tarea),
    puedeHacer(OtraPersona, Tarea),
    PersonaQueCubre \= OtraPersona.

esIrremplazable(Persona, Tarea):-
    puedeHacer(Persona, Tarea),
    not(puedeCubrir(_, Persona, Tarea)).



% quienes son camaradas, significa que comparten el mismo area