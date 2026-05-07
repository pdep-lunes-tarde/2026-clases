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

--- ^^ Hasta ahí llegamos en clase ^^ ---

--- vv Abajo sigue la resolución del resto del ejercicio vv ---

-- Implementar una función ajustadoPorIpc que dados un valor, una fecha origen y una nueva fecha destino, nos devuelva el valor ajustado por IPC.

ipcEn :: Periodo -> Number
ipcEn periodo = valorIpc (head (filter (\ipc -> periodoIpc ipc == periodo) valoresIpcCargados))

ajustadoPorIpc :: Number -> Periodo -> Periodo -> Number
ajustadoPorIpc valor periodoOrigen periodoDestino = (valor / ipcEn periodoOrigen) * ipcEn periodoDestino

-- Ahora queremos, dado un sueldo de un docente en un determinado período de referencia (año + mes),
-- ajustarlo por ipc a cada período (año + mes) del 2026.

-- Se van a usar periodos de referencia en todas las funciones a partir de acá, lo dejamos como un valor
-- que se usa en todos lados.
periodoDeReferencia :: Periodo
periodoDeReferencia = UnPeriodo 2023 Noviembre

salarioRealEn :: Docente -> Periodo -> Number
salarioRealEn docente periodo = valorSalario (head (filtrarPeriodo periodo (sueldosAnualesDocente docente (anio periodo))))

-- Se usa como base el periodoDeReferencia definido arriba, y se quiere saber, partiendo de cuanto cobraba en ese entonces
-- cuanto debería cobrar en el periodoDestino si se ajustase por ipc.
salarioAjustadoEn :: Docente -> Periodo -> Number
salarioAjustadoEn docente periodoDestino = ajustadoPorIpc (salarioRealEn docente periodoDeReferencia)
                                                                                        periodoDeReferencia
                                                                                        periodoDestino

-- Con esto ya se puede comparar a ojo haciendo:
-- >>> salarioRealEn juan (UnPeriodo 2026 Marzo)    

-- >>> salarioAjustadoEn juan (UnPeriodo 2026 Marzo)

-- (Todavía no está publicado el valor de ipc de abril 2026, el archivo mas nuevo usado para los datos
-- es www.indec.gob.ar/ftp/cuadros/economia/sh_ipc_04_26.xls y la calculadora de inflación
-- https://www.indec.gob.ar/indec/web/Institucional-Indec-calculadora_variaciones_IPC)
ultimoPeriodoConDatos :: Periodo
ultimoPeriodoConDatos = UnPeriodo  2026 Marzo

periodos2026 :: [Periodo]
periodos2026 = filter (\periodo -> periodo <= ultimoPeriodoConDatos) (map (\mes -> UnPeriodo 2026 mes ) [Enero .. Diciembre])

valoresDeSueldosAjustadosA2026 :: Docente -> [Number]
valoresDeSueldosAjustadosA2026 docente = map (\periodo -> salarioAjustadoEn docente periodo) periodos2026

-- Lo siguiente es hacer una comparativa: dado un período para tomar de referencia,
-- un docente y un período destino, queremos saber qué tan por abajo o por arriba
-- está su sueldo real de su sueldo ajustado por ipc.

-- Por valor absoluto: Sueldo real - Sueldo ajustado por ipc.

-- Si da positivo significa que el salario le ganó a la inflación desde el periodoDeReferencia,
-- si da negativo que perdió.
diferenciaAbsolutaEntreRealYAjustado :: Docente -> Periodo -> Number
diferenciaAbsolutaEntreRealYAjustado docente periodo =
    salarioRealEn docente periodo - salarioAjustadoEn docente periodo
-- >>> diferenciaAbsolutaEntreRealYAjustado juan (UnPeriodo Marzo 2026)

-- Por porcentaje: (Sueldo real - Sueldo ajustado por ipc) / Sueldo real.
-- Si por ej diese 0.2, significa que el sueldo le ganó un 20% a la inflación, si fuese -0.1 que perdió 10% contra la inflación.
diferenciaPorcentualEntreRealYAjustado :: Docente -> Periodo -> Number
diferenciaPorcentualEntreRealYAjustado docente periodo =
    diferenciaAbsolutaEntreRealYAjustado docente periodo / salarioRealEn docente periodo
-- >>> diferenciaPorcentualEntreRealYAjustado juan (UnPeriodo Marzo 2026)

-- Usar esas 2 funciones para comparar los valores de los salario mes a mes
-- de un docente en 2026 contra los valores ajustados tomando como referencia alguna fecha en el pasado.
-- Se usa periodoDeReferencia que esta definida mas arriba.

-- Cada numero de la lista es cuanto le ganó o perdió el sueldo real contra la inflación
diferenciasAbsolutasEn2026 :: Docente -> [Number]
diferenciasAbsolutasEn2026 docente = map (\periodo -> diferenciaAbsolutaEntreRealYAjustado docente periodo) periodos2026
-- >>> diferenciasAbsolutasEn2026 juan

diferenciasPorcentualesEn2026 :: Docente -> [Number]
diferenciasPorcentualesEn2026 docente = map (\periodo -> diferenciaPorcentualEntreRealYAjustado docente periodo) periodos2026
-- >>> diferenciasPorcentualesEn2026 juan

-- Queremos contestar si hay algún mes en el cual el salario real fue mayor que el salario ajustado por ipc.
algunMesElSalarioRealFueMayorAlAjustadoEn2026 :: Docente -> Bool
algunMesElSalarioRealFueMayorAlAjustadoEn2026 docente = any (\diferencia -> diferencia > 0) (diferenciasAbsolutasEn2026 docente)
-- >>> algunMesElSalarioRealFueMayorAlAjustadoEn2026 juan

-- Dados varios docentes, queremos saber si dado un período de referencia y un período objetivo,
-- si a todos les dio un salario real menor al salario ajustado en ese período objetivo.
todosPerdieronContraLaInflacionEn :: [Docente] -> Periodo -> Bool
todosPerdieronContraLaInflacionEn docentes periodo = all (\docente -> diferenciaAbsolutaEntreRealYAjustado docente periodo < 0) docentes
-- >>> todosPerdieronContraLaInflacionEn [lucas, juan, tomas] (UnPeriodo 2026 Marzo)


--    ¿Cuál es el acumulado de plata que viene perdiendo un docente desde octubre de 2025 hasta la fecha?

-- Calculamos los periodos de incumplimiento de ley, desde Octubre 2025 hasta el último mes del que tenemos datos de ipc y salarios,
-- que está en la constante ultimoPeriodoConDatos.
periodosDesdeIncumplimientoDeLey :: [Periodo]
periodosDesdeIncumplimientoDeLey = map (\mes -> UnPeriodo  2025 mes) [Octubre .. Diciembre] ++ periodos2026
-- >>> periodosDesdeIncumplimientoDeLey

-- Se puede chequear cuantos meses van tambien así:
-- >>> length periodosDesdeIncumplimientoDeLey

perdidaMesAMesDesdeIncumplimientoDeLey :: Docente -> [Number]
perdidaMesAMesDesdeIncumplimientoDeLey docente = map (\periodo -> diferenciaAbsolutaEntreRealYAjustado docente periodo) periodosDesdeIncumplimientoDeLey
-- >>> perdidaMesAMesDesdeIncumplimientoDeLey juan

perdidaAcumuladaDesdeIncumplimientoDeLey :: Docente -> Number
perdidaAcumuladaDesdeIncumplimientoDeLey docente = sum (perdidaMesAMesDesdeIncumplimientoDeLey docente)
-- tambien se puede escribir como foldr (+) 0 (perdidaMesAMesDesdeIncumplimientoDeLey docente), pero siendo que existe
-- sum, usamos eso porque es más declarativo y tambien más expresivo.
-- >>> perdidaAcumuladaDesdeIncumplimientoDeLey juan

-- ¿Cuántos sueldos de ese docente son en la actualidad?
perdidaAcumuladaDesdeIncumplimientoDeLeyEnSueldosActuales :: Docente -> Periodo -> Number
perdidaAcumuladaDesdeIncumplimientoDeLeyEnSueldosActuales docente periodoActual =
    perdidaAcumuladaDesdeIncumplimientoDeLey docente / salarioRealEn docente periodoActual
-- se puede usar como:
-- >>> perdidaAcumuladaDesdeIncumplimientoDeLeyEnSueldosActuales juan ultimoPeriodoConDatos



