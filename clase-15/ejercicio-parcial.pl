% agregado predicado para tener un generador dios\1 que ligue Dios solo una vez con cada dios
dioses([atenea, hefesto, asclepios, apolo, zeus, hera, afrodita, demeter, persefone, hestia, hades, poseidon, hermes, dionisio, ares, artemisa, hebe, ilitia, triton, eros, fobos, deimos, harmonia, rea, cronos]).
dios(Dios):-
    dioses(Dioses),
    member(Dios, Dioses).

% 1 - Modelar las formas de adoración a los dioses

% adoracion(Ciudad, Adoracion)
adoracion(atenas, templo([atenea])).
adoracion(atenas, templo([hefesto, atenea])).
adoracion(atenas, templo([asclepios])).
adoracion(delfos, templo([apolo])).
adoracion(olimpia, templo([zeus])).
adoracion(olimpia, templo([hera])).

adoracion(esparta, procesion(tesmoforias)).
adoracion(atenas, procesion(tesmoforias)).
adoracion(esparta, procesion(afrodisias)).

adoracion(delfos, juegos(8, apolo)).
adoracion(olimpia, juegos(4, zeus)).
adoracion(corinto, juegos(2, poseidon)).

% agregado solo para los tests
adoracion(creta, juegos(3, hermes)).
ciudad(creta, 10000, dionisio).
dios(hermes).

% dura(Procesion, Dias)
dura(tesmoforias, 3).
dura(afrodisias, 1).

% procesion_honra_a(Procesion, Dios)
procesion_honra_a(tesmoforias, demeter).
procesion_honra_a(tesmoforias, persefone).
procesion_honra_a(afrodisias, afrodita).

% ciudad(Ciudad, Poblacion, DiosPatrono)
ciudad(atenas, 200000, atenea).
ciudad(delfos, 3000, apolo).
ciudad(esparta, 140000, apolo).
ciudad(olimpia, 10000, zeus).
ciudad(corinto, 70000, poseidon).

dios_patrono(Ciudad, Dios):-
    ciudad(Ciudad, _, Dios).

% 2 - Queremos implementar un predicado para contestar a que dios adora una ciudad.
% Una ciudad adora a un dios si construyó algún templo en su honor, festeja alguna procesión o juego en su honor o si es su dios patrono.
% Además, todas las ciudades griegas rinden culto a Hestia aunque no tengan un templo, procesión o juego destinados a ella.


% adora_a(Ciudad, Dios)
adora_a(Ciudad, Dios):-
    dios_patrono(Ciudad, Dios).
adora_a(Ciudad, Dios):-
    muestra_adoracion_con(Ciudad, Dios, _).
adora_a(Ciudad, hestia):-
    ciudad(Ciudad, _, _).

muestra_adoracion_con(Ciudad, Dios, Ritual):-
    adoracion(Ciudad, Ritual),
    muestra_adoracion_a(Ritual, Dios).

muestra_adoracion_a(templo(Dioses), Dios):-
    member(Dios, Dioses).
muestra_adoracion_a(procesion(Procesion), Dios):-
    procesion_honra_a(Procesion, Dios).
muestra_adoracion_a(juegos(_, Dios), Dios).

% 3 - Queremos saber si un dios adorado por alguna ciudad es un dios ambulante.
% Esto ocurre si ese dios no es patrono de ninguna ciudad y tampoco se construyó un templo en su honor.

dios_ambulante(Dios):-
    adora_a(_, Dios),
    not((adoracion(_, templo(Dioses)), member(Dios, Dioses))),
    not(dios_patrono(_, Dios)).

% 4 - Se busca calcular aproximadamente cuántos devotos tiene un dios en una ciudad.
% Podemos tomar en cuenta las distintas formas en las que se adoraban a los dioses para aproximar un número:


devotos(Ciudad, Dios, CantidadDeDevotos):-
    ciudad(Ciudad, _, _),
    dios(Dios),
    findall(Devotos, (muestra_adoracion_con(Ciudad, Dios, Ritual), devotos_por_muestra_de_adoracion(Ritual, Devotos)), DevotosPorMuestrasDeAdoracion),
    findall(Devotos, cantidad_devotos_por_dios_patrono(Dios, Ciudad, Devotos), DevotosPorSerPatrono),
    append(DevotosPorMuestrasDeAdoracion, DevotosPorSerPatrono, TodosLosDevotos),
    sum_list(TodosLosDevotos, CantidadDeDevotos).

% Por cada templo dedicado al dios en la ciudad, podemos calcular 2.000 devotos.
devotos_por_muestra_de_adoracion(templo(_), 2000).
% Por cada procesión dedicada al dios en la ciudad, podemos calcular 15.000 devotos dividido la cantidad de días de procesión.
devotos_por_muestra_de_adoracion(procesion(Procesion), Devotos):-
    dura(Procesion, Duracion),
    Devotos is 15000 / Duracion.
% Por cada juego dedicado al dios en la ciudad, calculamos 10.000 devotos multiplicado por la cantidad de años que pasaban entre cada edición de esos juegos.
devotos_por_muestra_de_adoracion(juegos(Anios, _), Devotos):-
    Devotos is Anios * 10000.
% Si el dios es patrono de la ciudad, estimamos que tres cuartos de los habitantes de la misma son devotos del dios.
cantidad_devotos_por_dios_patrono(Dios, Ciudad, Devotos):-
    ciudad(Ciudad, Poblacion, Dios),
    Devotos is Poblacion * 3 / 4.

% 5 - Queremos saber quien es el dios más famoso en toda Grecia, que es aquel que más devotos tiene entre todas las ciudades.
devotos_totales(Dios, CantidadDeDevotos):-
    devotos(_, Dios, _),
    findall(Devotos, devotos(_, Dios, Devotos), TodosLosDevotos),
    sum_list(TodosLosDevotos, CantidadDeDevotos).

dios_mas_famoso(Dios):-
    devotos_totales(Dios, CantidadDevotos),
    forall(devotos_totales(_, OtraCantidadDevotos), OtraCantidadDevotos =< CantidadDevotos).

% 6 - Queremos saber para cada dios, cuál es la ciudad donde tiene más devotos.
ciudad_mas_devota(Dios, Ciudad):-
    devotos(Ciudad, Dios, CantidadDevotos),
    forall(devotos(_, Dios, OtraCantidadDeDevotos), OtraCantidadDeDevotos =< CantidadDevotos).

% 7 - El árbol genealógico
% Implementar un predicado que nos permite contestar cuál es la relación de parentesco entre dos personas,
% teniendo en cuenta que. El predicado debería soportar las siguientes relaciones de parentesco:
% cónyuge, progenitor, hijo, tío, sobrino, primo, hermano (con que tengan un progenitor en común los consideramos hermanos).
casados(rea, cronos).
padre_de(rea, [hestia, demeter, hera, hades, poseidon, zeus]).
padre_de(cronos, [hestia, demeter, hera, hades, poseidon, zeus]).
casados(zeus, hera).
padre_de(zeus, [ares, hebe, ilitia]).
padre_de(hera, [ares, hebe, ilitia]).
padre_de(zeus, [atenea, apolo, artemisa, hermes, dionisio, persefone, hercules, perseo, helena, minos]).
padre_de(hera, [hefesto]).
padre_de(demeter, [persefone]).
casados(persefone, hades).
casados(hefesto, afrodita).
padre_de(poseidon, [triton, teseo]).
padre_de(afrodita, [fobos, deimos, harmonia, eros]).
padre_de(ares, [fobos, deimos, harmonia, eros]).
padre_de(apolo, [asclepios]).

parentesco(UnConyuge, OtroConyuge, conyuge):-
    casados(UnConyuge, OtroConyuge).
% el segundo caso es para que sea simetrico el predicado
parentesco(OtroConyuge, UnConyuge, conyuge):-
    casados(UnConyuge, OtroConyuge).
parentesco(Padre, Hijo, progenitor):-
    padre_de(Padre, Hijos),
    member(Hijo, Hijos).
parentesco(Hijo, Padre, hijo):-
    parentesco(Padre, Hijo, progenitor).
parentesco(UnHermano, OtroHermano, hermano):-
    parentesco(Padre, UnHermano, progenitor),
    parentesco(Padre, OtroHermano, progenitor),
    UnHermano \= OtroHermano.
parentesco(Tio, Sobrino, tio):-
    parentesco(Tio, Padre, hermano),
    parentesco(Padre, Sobrino, progenitor).
parentesco(Sobrino, Tio, sobrino):-
    parentesco(Tio, Sobrino, tio).
parentesco(UnPrimo, OtroPrimo, primo):-
    parentesco(UnPadre, UnPrimo, progenitor),
    parentesco(OtroPadre, OtroPrimo, progenitor),
    parentesco(UnPadre, OtroPadre, hermano).

:- begin_tests(practica_parcial).

test("una ciudad adora a su dios patrono", nondet):-
    adora_a(esparta, apolo).
test("una ciudad no adora a un dios si no es su patrono y no tiene ningun ritual de adoracion hacia ese dios", nondet):-
    not(adora_a(esparta, atenea)).
test("una ciudad adora a un dios si construyo un templo a ese dios", nondet):-
    adora_a(atenas, asclepios).
test("una ciudad adora a un dios si festeja alguna procesion en honor a ese dios", nondet):-
    adora_a(esparta, afrodita).
test("una ciudad adora a un dios si festeja juegos en honor a ese dios", nondet):-
    adora_a(corinto, poseidon).
test("todas las ciudades adoran a hestia", nondet):-
    adora_a(corinto, hestia).

test("un dios es ambulante si es adorado por una ciudad pero no es patrono de ninguna ni tiene templos en su honor", nondet):-
    dios_ambulante(hestia).
test("un dios no es ambulante si no es adorado por ninguna ciudad"):-
    not(dios_ambulante(hades)).
test("un dios no es ambulante si tiene algun templo en su honor"):-
    not(dios_ambulante(atenea)).
test("un dios no es ambulante si es patrono de alguna ciudad"):-
    not(dios_ambulante(poseidon)).

test("si un dios tiene un templo en su honor, eso representa 2000 devotos en esa ciudad", nondet):-
    devotos(atenas, asclepios, 2000).
test("si un dios tiene una procesion en su honor en una ciudad, eso representa tantos devotos como 15000 dividido la cantidad de dias de procesion", nondet):-
    devotos(esparta, afrodita, 15000).
test("si un dios tiene juegos en su honor en una ciudad, eso representa 10000 devotos por la cantidad de anios que hay entre cada edicion de esos juegos", nondet):-
    devotos(creta, hermes, 30000).
test("si un dios es patrono de una ciudad en una ciudad, eso representa tantos devotos como 3/4 de la poblacion de la ciudad", nondet):-
    devotos(esparta, apolo, 105000).
test("el total de devotos de un dios es la suma de los devotos que tiene por cada muestra de adoracion y por ser dios patrono", nondet):-
    devotos(atenas, atenea, 154000).

test("el dios mas famoso es aquel que tiene mas devotos entre todas las ciudades", nondet):-
    dios_mas_famoso(apolo).
test("si un dios no es el que mas devotos tiene no es el mas famoso", nondet):-
    not(dios_mas_famoso(poseidon)).

test("la ciudad mas devota es aquella en la que un dios tiene mas devotos", nondet):-
    ciudad_mas_devota(apolo, esparta).
test("una ciudad no es la mas devota de un dios si existe otra que tenga mas devotos", nondet):-
    not(ciudad_mas_devota(apolo, delfos)).

test("dos personas son conyuges si estan casadas", nondet):-
    parentesco(zeus, hera, conyuge),
    parentesco(hera, zeus, conyuge).
test("dos personas NO son conyuges si no estan casadas", nondet):-
    not(parentesco(afrodita, ares, conyuge)).
test("una persona es progenitora de la otra si es su padre", nondet):-
    parentesco(zeus, persefone, progenitor).
test("una persona NO es progenitora de la otra si NO es su padre", nondet):-
    not(parentesco(cronos, asclepios, progenitor)).
test("una persona es hija de otra si la otra es su padre", nondet):-
    parentesco(asclepios, apolo, hijo).
test("una persona NO es hija de otra si la otra NO es su padre"):-
    not(parentesco(hades, hera, hijo)).
test("una persona es hermana de otra si tienen un padre en comun", nondet):-
    parentesco(poseidon, zeus, hermano),
    parentesco(zeus, poseidon, hermano).
test("una persona NO es hermana de otra si NO tienen un padre en comun", nondet):-
    not(parentesco(poseidon, apolo, hermano)).
test("una persona NO es su propia hermana", nondet):-
    not(parentesco(apolo, apolo, hermano)).
test("una persona es tia de otra si es hermana de uno de sus progenitores", nondet):-
    parentesco(hestia, atenea, tio).
test("una persona NO es tia de otra si es NO hermana de uno de sus progenitores", nondet):-
    not(parentesco(artemisa, atenea, tio)).
test("una persona es sobrina de otra si la otra es su tio", nondet):-
    parentesco(atenea, poseidon, sobrino).
test("una persona NO es sobrina de otra si la otra NO es su tio", nondet):-
    not(parentesco(apolo, cronos, sobrino)).
test("dos personas son primos si alguno de sus progenitores son hermanos", nondet):-
    parentesco(teseo, hercules, primo).
test("dos personas NO son primos si ninguno de sus progenitores son hermanos", nondet):-
    not(parentesco(asclepios, cronos, primo)).
test("una persona NO es su propio primo", nondet):-
    not(parentesco(hercules, hercules, primo)).

:- end_tests(practica_parcial).