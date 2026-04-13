module Library (module Library, isPrefixOf, isSuffixOf) where

import PdePreludat
import Data.List (isPrefixOf, isSuffixOf)

valorAbsoluto :: Number -> Number
valorAbsoluto x
    | x >= 0 = x
    | otherwise = -x


estaEntre :: Ord a => a -> a -> a -> Bool
-- estaEntre valor unaCota otraCota
--    = valor >= unaCota && valor <= otraCota

estaEntre valor unaCota otraCota
    | unaCota <= otraCota = unaCota <= valor && valor <= otraCota
    | unaCota > otraCota  = unaCota >= valor && valor >= otraCota

estaEntre' valor unaCota otraCota
    | unaCota <= otraCota = unaCota <= valor && valor <= otraCota
    | otherwise = estaEntre' valor otraCota unaCota

estaEntre'' :: Ord a => a -> a -> a -> Bool
estaEntre'' valor unaCota otraCota =
    valor >= min unaCota otraCota && valor <= max unaCota otraCota

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
