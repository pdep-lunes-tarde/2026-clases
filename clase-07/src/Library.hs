{-# LANGUAGE BangPatterns #-}
{-# LANGUAGE RankNTypes #-}

module Library where

import PdePreludat

verdadero :: Booleano
verdadero = \ramaDeSi ramaDeNo -> ramaDeSi

-- >>> verdadero "Si" "No"
-- "Si"

falso :: Booleano
falso = \ramaDeSi ramaDeNo -> ramaDeNo

-- >>> falso "Si" "No"
-- "No"

o :: Booleano -> Booleano -> Booleano
o unBooleano otroBooleano = unBooleano verdadero otroBooleano

-- >>> (o verdadero undefined) "Si" "No"
-- "Si"

y :: Booleano -> Booleano -> Booleano
y unBooleano otroBooleano = unBooleano otroBooleano falso

-- >>> (y verdadero verdadero) "Si" "No"
-- "Si"

no :: Booleano -> Booleano
no unBooleano = unBooleano falso verdadero

-- >>> (no verdadero) "Si" "No"
-- "No"

type Booleano = forall a. a -> a -> a

-- listas!

unos :: [Number]
unos = 1 : unos

-- >>> head unos
-- 1

naturales :: [Number]
naturales = 1 : (map (+1) naturales)

-- >>> take 5 naturales
-- [1,2,3,4,5]


losNaturalesPares :: [Number]
losNaturalesPares = filter even naturales

-- >>> take 11 losNaturalesPares
-- [2,4,6,8,10,12,14,16,18,20,22]

losNaturalesPares' :: [Number]
losNaturalesPares' = map (*2) naturales

-- >>> take 11 losNaturalesPares'
-- [2,4,6,8,10,12,14,16,18,20,22]

-- no termina :(
losNaturalesMenoresA5 :: [Number]
losNaturalesMenoresA5 = filter (<5) naturales

-- no termina :(
hayAlgunNaturalMenorA0 :: Bool
hayAlgunNaturalMenorA0 = any (<0) naturales

hayAlgunMayorA1 :: Bool
hayAlgunMayorA1 = any (>1) naturales

sonTodosMayoresA2 :: Bool
sonTodosMayoresA2 = all (>2) naturales

sumatoria :: [Number] -> Number
sumatoria = sum

-- no termina :(
sumatoriaDeTodosLosN :: Number
sumatoriaDeTodosLosN = sumatoria naturales

-- no termina :(
funcionQueNoTermina :: a -> a
funcionQueNoTermina x = funcionQueNoTermina x

mapIndex :: (Number -> a -> b) -> [a] -> [b]
mapIndex func lista = zipWith func [0..] lista

indexado :: [String] -> [String]
indexado palabras =
  mapIndex
    (\indice palabra -> show indice ++ palabra)
    palabras

-- >>> indexado ["hola", "chau", "ble"]
-- ["0hola","1chau","2ble"]

serieDeFactoriales :: [Number]
serieDeFactoriales = 1 :
  zipWith (*) [1..] serieDeFactoriales

-- >>> take 10 serieDeFactoriales
-- [1,1,2,6,24,120,720,5040,40320,362880]

data Persona = Persona
  { nombre :: String
  , padres :: [Persona]
  }

mildred :: Persona
mildred = Persona "Mildred Fry" []
sherri :: Persona
sherri = Persona "Sherri Fry" []
fry :: Persona
fry = Persona "Philip J Fry" [sherri, yancy]
yancy :: Persona
yancy = Persona "Yancy Fry" [mildred, fry]

-- >>> map nombre $ concat $ map padres $ padres yancy
-- ["Sherri Fry","Yancy Fry"]
