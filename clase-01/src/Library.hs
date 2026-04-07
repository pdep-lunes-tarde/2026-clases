module Library where
import PdePreludat

-- Ejercicios

-- Doble
-- Dado un número me devuelve el doble del mismo

-- f(x) = 2x

duplicar :: Number -> Number
duplicar x = 2 * x

sumar :: Number -> Number -> Number
sumar x y = x + y

saludar :: String -> String
saludar nombre = "Hola " ++ nombre

-- doble = implementame

-- Año bisiesto
-- Un año es bisiesto si es divisible por 400
-- o si es divisible por 4 pero no por 100.

bisiesto :: Number -> Bool
bisiesto año =
    esDivisiblePor año 400 ||
    esDivisiblePor año 4 && not (esDivisiblePor año 100)

esDivisiblePor :: Number -> Number -> Bool
esDivisiblePor dividendo divisor = mod dividendo divisor == 0

-- Declaratividad

-- int coso(int a[], int b) {
--   int c, d = 0;
--   for (c = 0; c < b; c++) {
--     if (a[c] % 2 == 0) {
--       d = d + 1;
--     }
--   }
--   return d;
-- }

cuantosPares :: [Number] -> Number
cuantosPares = length . filter even