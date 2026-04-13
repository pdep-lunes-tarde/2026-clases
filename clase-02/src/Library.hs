module Library (module Library, isPrefixOf, isSuffixOf) where

import PdePreludat
import Data.List (isPrefixOf, isSuffixOf)

-- estaEntre = implementame

-- valorAbsoluto = implementame

-- preguntar :: String -> String
-- preguntar oracion
--     | isPrefixOf "¿" oracion && isSuffixOf "?" oracion = oracion
--     | "¿" `isPrefixOf` oracion = oracion ++ "?"
--     | "?" `isSuffixOf` oracion = "¿" ++ oracion
--     | otherwise = "¿" ++ oracion ++ "?"

preguntar :: String -> String
preguntar oracion = implementame

-- isPrefixOf nos dice si un string empieza con otro string
-- isSuffixOf nos dice si un string termina con otro string
-- ++

-- >>> isSuffixOf "ojos" "anteojos"
-- True
--
-- >>> isPrefixOf "ante" "anteojos"
-- True
--
-- >>> "hola " ++ "mundo"
-- "hola mundo"

-- Queremos que funcione así:
-- >>> preguntar "hola"
-- "¿hola?"-- >>> preguntar "hola?"
-- "¿hola?"
