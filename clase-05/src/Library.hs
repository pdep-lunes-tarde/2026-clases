module Library where
import PdePreludat
import Types
import CargarDatos (valoresIpcCargados, salariosCargados)

juan :: Docente
juan = UnDocente { nombreDocente = "Juan", categoriaDocente = Adjunto, dedicacionDocente = Simple }
tomas :: Docente
tomas = UnDocente { nombreDocente = "Tomas", categoriaDocente = JTP, dedicacionDocente = Simple }
lucas :: Docente
lucas = UnDocente { nombreDocente = "Lucas", categoriaDocente = Titular, dedicacionDocente = Exclusiva }

-- a) Corresponden a cierta categoría.
-- b) Corresponden a cierta dedicación.
-- c) Sean de un año particular.
-- d) Sean de un período (año + mes) en particular.

-- hacerDosVeces (\x -> x + 2) 4

-- hacerDosVeces funcion valor = funcion (funcion valor)

type AtributoDeSalario a = SalarioBasico -> a

filtrarSegun :: Eq a => (SalarioBasico -> a) -> a -> [SalarioBasico] -> [SalarioBasico]
filtrarSegun obtenerValor valorBuscado salarios =
    filter (\salario -> (obtenerValor salario) == valorBuscado) salarios

filtrarCategoria :: Categoria -> [SalarioBasico] -> [SalarioBasico]
-- filtrarCategoria categoriaBuscada salarios =
    -- filter (\salario -> categoriaSalario salario == categoriaBuscada) salarios
filtrarCategoria categoriaBuscada salarios =
    filtrarSegun categoriaSalario categoriaBuscada salarios

filtrarDedicacion :: Dedicacion -> [SalarioBasico] -> [SalarioBasico]
-- filtrarDedicacion dedicacionBuscada salarios =
    -- filter (\salario -> dedicacionSalario salario == dedicacionBuscada) salarios
filtrarDedicacion dedicacionBuscada salarios =
    filtrarSegun dedicacionSalario dedicacionBuscada salarios

filtrarAnio :: Number -> [SalarioBasico] -> [SalarioBasico]
-- filtrarAnio anioBuscado salarios =
--     filter (\salario -> anioSalario salario == anioBuscado) salarios
filtrarAnio anioBuscado salarios =
    filtrarSegun anioSalario anioBuscado salarios

filtrarPeriodo :: Periodo -> [SalarioBasico] -> [SalarioBasico]
-- filtrarPeriodo periodoBuscado salarios =
--     filter (\salario -> periodoSalario salario == periodoBuscado) salarios
filtrarPeriodo periodoBuscado salarios =
     filtrarSegun periodoSalario periodoBuscado salarios

sueldosAnualesDocente :: Docente -> Number -> [SalarioBasico]
sueldosAnualesDocente unDocente unAnio =
    filtrarDedicacion (dedicacionDocente unDocente)
                      (filtrarCategoria (categoriaDocente unDocente)
                                        (filtrarAnio unAnio salariosCargados))

valoresDeSueldosAnualesDocente :: Docente -> Number -> [Number]
valoresDeSueldosAnualesDocente unDocente unAnio =
    map valorSalario (sueldosAnualesDocente unDocente unAnio)

-- Quiero saber si un docente cobró mas de 300mil un año
cobroMasQue300kAlgunAnio :: Docente -> Number -> Bool
cobroMasQue300kAlgunAnio unDocente unAnio =
    any (\sueldo -> sueldo > 300000)
        (valoresDeSueldosAnualesDocente unDocente unAnio)

-- algunoCumple en haskell se llama any
algunoCumple :: (a -> Bool) -> [a] -> Bool
algunoCumple condicion [] = False
algunoCumple condicion (x : xs) =
    condicion x || algunoCumple condicion xs

-- algunoEsMasQue300mil :: [Number] -> Bool
-- algunoEsMasQue300mil [] = False
-- algunoEsMasQue300mil (numero : numeros) =
--     (numero > 300000) || algunoEsMasQue300mil numeros

totalCobradoEnAnio :: Docente -> Number -> Number
totalCobradoEnAnio unDocente unAnio = 
    sum (valoresDeSueldosAnualesDocente unDocente unAnio)

-- sum
sumatoria :: [Number] -> Number
sumatoria numeros = foldr (+) 0 numeros

producto :: [Number] -> Number
producto numeros = foldr (*) 1 numeros

foldl' :: (b -> a -> b) -> b -> [a] -> b
foldl' = implementame

foldr' :: (a -> b -> b) -> b -> [a] -> b
foldr' = implementame

-- salariosBasicosAValores es equivalente a (map valorSalario)
--
-- salariosBasicosAValores [] = []
-- salariosBasicosAValores (unSalario : otrosSalarios) =
--     (valorSalario unSalario : salariosBasicosAValores otrosSalarios)


-- map' :: (a -> b) -> [a] -> [b]
-- map' _ [] = []
-- map' f (x : xs) = (f x : map' f xs)

anioSalario :: SalarioBasico -> Number
anioSalario salario = anio (periodoSalario salario)

