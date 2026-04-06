module Library where
import PdePreludat

-- Ejercicios

-- Doble
-- Dado un número me devuelve el doble del mismo

doble = implementame

-- Año bisiesto
-- Un año es bisiesto si es divisible por 400
-- o si es divisible por 4 pero no por 100.

bisiesto = implementame

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