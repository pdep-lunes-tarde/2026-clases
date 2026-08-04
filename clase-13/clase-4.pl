/*animal(Nombre,Clase, Medio)*/
animal(ballena,mamifero,acuatico).
animal(tiburon,pez,acuatico).
animal(lemur,mamifero,terrestre).
animal(golondrina,ave,aereo).
animal(tarantula,insecto,terrestre).
animal(lechuza,ave,aereo).
animal(orangutan,mamifero,terrestre).
animal(tucan,ave,aereo).
animal(puma,mamifero,terrestre).
animal(abeja,insecto,aereo).
animal(leon,mamifero,terrestre).
animal(lagartija,reptil,terrestre).


/* tiene(Quien, Que, Cuantos)*/
tiene(nico, ballena, 1).
tiene(nico, lemur, 2).
tiene(maiu, lemur, 1).
tiene(maiu, tarantula, 1).
tiene(juanDS, golondrina, 1).
tiene(juanDS, lechuza, 1).
tiene(juanR, tiburon, 2).
tiene(nico, golondrina, 1).
tiene(juanDS, puma, 1).
tiene(maiu, tucan, 1).
tiene(juanR, orangutan,1).
tiene(maiu,leon,2).
tiene(juanDS,lagartija,1).
tiene(feche,tiburon,1).

tiene(luis, tiburon, 10).
tiene(luis, ballena, 10).
% tiene(luis, leon, 1).

leGusta(luis, tiburon).
leGusta(luis, ballena).
leGusta(luis, lemur).

% leGusta(Persona, Animal).

leGusta(nico, Animal) :- 
    animal(Animal, _, terrestre),
    Animal \= lemur.

leGusta(maiu, abeja).
leGusta(maiu, Animal) :- 
    animal(Animal, _, _),
    not(animal(Animal, insecto, _)).

leGusta(ema, Animal) :- leGusta(maiu, Animal).

% animalDificil/1: que se cumple para los animales que nadie tiene o que como mucho hay una sola persona que tiene sólo uno.

animalDificil(Animal) :- nadieTiene(Animal).
animalDificil(Animal) :- soloTieneUnoDe(Animal).

nadieTiene(Animal) :- 
    animal(Animal, _, _),
    not(tiene(_, Animal, _)).

soloTieneUnoDe(Animal) :-
    tiene(Persona, Animal, 1),
    not(
        (tiene(Otra, Animal, _), Otra \= Persona)
    ).

persona(Persona) :- tiene(Persona, _, _).

estaTriste(Persona) :-
    persona(Persona),
    not(estaCotenta(Persona)).

estaCotenta(Persona) :-
    tiene(Persona, Animal, _),
    leGusta(Persona, Animal).



tieneTodosAcuaticos(Persona) :-
    persona(Persona),
    forall(
        tiene(Persona, Animal, _), 
            animal(Animal, _, acuatico)
    ).

coleccionoTodosLosAcuaticos(Persona) :-
    persona(Persona),
    forall(
        animal(Animal, _, acuatico),
            tiene(Persona, Animal, _)
    ).


estaFeliz(Persona) :-
    persona(Persona),
    forall(tiene(Persona, Animal, _), leGusta(Persona, Animal)).
    
delQueMasTiene(Persona, Animal) :-
    tiene(Persona, Animal, CantidadMaxima),
    forall(
        tiene(Persona, _, Cantidad), 
            Cantidad =< CantidadMaxima
    ).
