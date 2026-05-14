module Library where
import PdePreludat

data Hotel = Hotel [Habitacion]
    deriving (Eq, Show)

data Habitacion = Habitacion Number Reserva
    deriving (Eq, Show)

data Reserva = Libre | Reservada String
    deriving (Eq, Show)

habitaciones :: Hotel -> [Habitacion]
habitaciones (Hotel h) = h

-- Hilbert imagines a hypothetical hotel with rooms numbered 1, 2, 3, and so on with no upper limit.

hotelDeHilbert :: Hotel
hotelDeHilbert = Hotel (map (\numero -> Habitacion numero Libre) [1..])

modificarHabitaciones :: ([Habitacion] -> [Habitacion]) -> Hotel -> Hotel
modificarHabitaciones modificacion (Hotel habitaciones) = Hotel (modificacion habitaciones)

-- Finitely many new guests

-- With one additional guest, the hotel can accommodate them and the existing guests if infinitely many
-- gHabitacion { numero = 1, reserva = (Reservada nombreNuevoHuesped) }currently in room 1 moves to room 2, the guest currently
-- in room 2 to room 3, and so on, moving every guest from their current room, n, to room n+1. 

cambiarNumero :: (Number -> Number) -> Habitacion -> Habitacion
cambiarNumero modificacion (Habitacion numero reserva) = Habitacion (modificacion numero) reserva

hospedar :: String -> Hotel -> Hotel
hospedar nombreNuevoHuesped (Hotel habitaciones) = Hotel $
    Habitacion 1 (Reservada nombreNuevoHuesped) : map (cambiarNumero (+1)) habitaciones

hospedarVarios :: [String] -> Hotel -> Hotel
hospedarVarios nombresNuevosHuespedes hotel = foldr hospedar hotel nombresNuevosHuespedes

-- Infinitely many new guests

-- It is also possible to accommodate a countably infinite number of new guests: just move the person occupying room 1 to room 2,
-- the guest occupying room 2 to room 4, and, in general, the guest occupying room n to room 2n (2 times n),
-- and all the odd-numbered rooms (which are countably infinite) will be free for the new guests.

hospedarInfinitos :: [String] -> Hotel -> Hotel
hospedarInfinitos nombresNuevosHuespedes (Hotel habitaciones) = Hotel $
    intercalar (zipWith (\huesped numero  -> Habitacion numero (Reservada huesped)) nombresNuevosHuespedes [1, 3..]) (map (cambiarNumero (*2)) habitaciones)

intercalar :: [a] -> [a] -> [a]
intercalar [] ys = ys
intercalar xs [] = xs
intercalar (x:xs) (y:ys) = (x:y:intercalar xs ys)
