module Library where
import PdePreludat

-- Los constructores de las listas son:
-- [] , lista vacía.
-- : , lista formada por un primer elemento y otra lista, por ejemplo: 1:[] es la lista con el elemento 1.

-- También se pueden escribir así: [1, 2, 4], que es equivalente a 1 : 2 : 4 : [].

-- Pattern matching sobre listas:
-- Patrón   | Denota
-- []       | Lista vacía, no se puede separar en cabeza y cola
-- (x:xs)   | El operador : separa cabeza y cola de una lista.
--          | Lista que tiene al menos un elemento, donde la cabeza es un elemento x,
--          | y la cola es una lista (son muchos x, por eso la convención es xs). Algunos ejemplos: 
--          |
-- (x:y:ys) | Lista de al menos 2 elementos.
-- [x]      | Lista de exactamente un elementos, no lista vacia
-- [x, y]   | Lista de exactamente dos elementos.

-- De nuevo, a partir de [] y (x:xs) se puede representar cualquiera de las otras combinaciones.
-- Por ejemplo, el patrón [x] se puede reescribir como (x:[]).

-- Definamos algunas funciones para las listas:

-- cabeza nos devuelve el primer elemento, está función ya existe en haskell y se llama head
cabeza :: [a] -> a
cabeza (x:_) = x

-- cola nos devuelve todos los elementos excepto el primero, está función también ya existe y se llama tail
cola :: [a] -> [a]
cola (x:xs) = xs

-- Ambas funciones fallan para listas vacías, ya que solo tienen el patrón de una lista con elementos (x:xs).

-- estaVacia nos devuelve true si la lista es la vacía y false si tiene algún elemento, está función en haskell se llama null.
estaVacia :: [a] -> Bool
estaVacia [] = True
estaVacia _ = False

-- Dato: ¡los strings son listas de chars!, es decir: "hola" es exactamente lo mismo a ['h', 'o', 'l', 'a'], y el tipo
-- String es solo un alias del tipo [Char].
-- Relacionado a eso, las listas solo pueden tener elementos de UN tipo, no se puede tener una lista así: ["asd", 2, 3],
-- y el tipo de la lista depende del tipo de sus elementos. El tipo de [1,2,3] es [Number], y el de ["uno", "dos"] es [String], o [[Char]].


-- RECURSIVIDAD

-- Una función que se usa a si misma es recursiva.

-- Ejemplo:
factorial :: Number -> Number
factorial n 
  | n == 0     = 1
  | n > 0      = n * factorial (n - 1)

-- Que tambien se puede escribir con pattern matching así:
factorial 0  =  1
factorial n  =  n * factorial (n - 1)

-- Pero ojo, en ese caso si pasamos un negativo va a quedar en loop infinito.
-- Por suerte, podemos mezclar pattern matching con guardas:
factorial' :: Number -> Number
factorial' 0  =  1
factorial' n | n > 0 =  n * factorial (n - 1)

-- recordemos: todo algoritmo recursivo debe tener
-- - un caso base para cortar la recursividad
-- - un caso recursivo para que verdaderamente exista recursividad

-- Recursividad con listas

-- Repasemos la definición de una lista, que tiene una estructura recursiva:
-- - el caso base es la lista vacía
-- - el caso recursivo es una lista de 1 ó más elementos, cuya cabeza es el primer elemento y cuya cola es una lista con los restantes

-- La longitud de una lista se calcula como
-- - caso base: 0 si la lista es vacía
-- - caso recursivo: la longitud de la cola + 1.

-- Esta función en haskell se llama length
longitud :: [a] -> Number
longitud [] = 0
longitud (x:xs) = 1 + longitud xs

-- sumatoria
-- La lógica es similar a la longitud. Si no hay elementos, la suma es 0. Si hay, es el valor de la cabeza + la sumatoria de la cola.

-- En haskell se llama sum
sumatoria :: [Number] -> Number
sumatoria [] = 0
sumatoria (x:xs) = x + sumatoria xs

-- ultimo, o last en haskell

-- Aquí estamos usando como pattern matching del caso base una lista de un elemento, en lugar de una lista vacía. Recordemos que
-- [x] implica que la lista tiene un solo elemento (no matchea con dos, tres elementos ni con una lista vacía)
-- (x:xs) permite matchear con una lista que tiene al menos un elemento. No obstante, el primer patrón tiene precedencia por lo que el efecto que tiene en la definición de la función last es que el segundo patrón solo encaja para listas de dos o más elementos: no es posible encajar en dos definiciones diferentes por el concepto de unicidad de función. 

ultimo :: [a] -> a
ultimo [x] = x
ultimo (x:xs) = last xs

-- tomarPrimeros
-- > tomarPrimeros 3 [1, 4, 2, 6, 7, 10]
-- [1, 4, 2]
-- Nos devuelve los primeros n elementos, está función se llama take.

-- Para tomar los primeros n elementos tenemos dos casos base
-- si ya saqué n elementos, no hay más elementos para sacar
-- si la lista se vació, no hay más elementos para sacar: ese “no hay más elementos” es la lista vacía

-- En el caso recursivo, la lista resultante se forma con el elemento que está en la cabeza y los (n - 1) elementos que le saque a la cola

tomarPrimeros :: Number -> [a] -> [a]
tomarPrimeros n _  | n <= 0  = []   
tomarPrimeros _ []           = []
tomarPrimeros n (x:xs)       = x : tomarPrimeros (n - 1) xs

-- concatenar, o (++) en haskell
-- > concatenar "has" "kell"
-- "haskell"

-- Para concatenar dos listas, 
-- si la primera lista es vacía, la lista resultante es la segunda lista
-- en cambio, si hay elementos en la primera lista, estos elementos formarán parte de la lista resultante (respetando ese orden)

concatenar :: [a] -> [a] -> [a]
concatenar []     x2 = x2
concatenar (x:xs) x2 = x : concatenar xs x2

-- (las listas deben ser del mismo tipo para poderlas concatenar en una sola)

-- Un par de funciones más:
-- Supongamos que queremos convertir una lista de caracteres en una lista de los números en ascii que los identifican, por ej:
-- "hola" en [104, 111, 108, 97]

-- Dada una función charAAscii que podría implementarse así (no importa mucho como funciona):
charAAscii :: Char -> Number
charAAscii char = integralToNumber (fromEnum char)

-- Podemos implementar charsANumeros así:

charsANumeros :: String -> [Number]
charsANumeros [] = [] -- si la lista está vacía terminamos
charsANumeros (char : resto) = (charAAscii char : charsANumeros resto) -- si no, hay que transformar al primer elemento (char) y repetir con el resto de la lista

-- Otro ejemplo, imaginemos que queremos filtrar una lista de números para quedarnos solo con aquellos
-- que sean pares:

pares :: [Number] -> [Number]
pares [] = [] -- si la lista está vacía terminamos
pares (numero : otrosNumeros)
  | even numero = numero : pares otrosNumeros -- el numero pasó el chequeo, aparece en la lista que retornamos
  | otherwise = pares otrosNumeros -- el numero no era par, entonces iteramos recursivamente sobre el resto de la lista ignorando ese número