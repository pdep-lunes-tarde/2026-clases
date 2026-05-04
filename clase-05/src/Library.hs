module Library where
import PdePreludat
import Types
import CargarDatos (cargarIpc, cargarTodosSalarios)
import GHC.IO (unsafePerformIO)

salarios :: [SalarioBasico]
salarios = unsafePerformIO cargarTodosSalarios

ipc :: [Ipc]
ipc  = unsafePerformIO cargarIpc

juan :: Docente
juan = Docente { nombreDocente = "Juan", categoriaDocente = Adjunto, dedicacionDocente = Simple }

tomas :: Docente
tomas = Docente { nombreDocente = "Tomás", categoriaDocente = JTP, dedicacionDocente = Simple }

lucas :: Docente
lucas = Docente { nombreDocente = "Lucas", categoriaDocente = Titular, dedicacionDocente = Exclusiva }

filtrarPocategoriaSalario :: Categoria -> [SalarioBasico] -> [SalarioBasico]
filtrarPocategoriaSalario unaCategoria salarios = filter (\salario -> categoriaSalario salario == unaCategoria) salarios

filtrarPodedicacionSalario :: Dedicacion -> [SalarioBasico] -> [SalarioBasico]
filtrarPodedicacionSalario unaDedicacion salarios = filter (\salario -> dedicacionSalario salario == unaDedicacion) salarios

filtrarPorAnio :: Number -> [SalarioBasico] -> [SalarioBasico]
filtrarPorAnio unAnio salarios = filter (\salario -> anio (periodoSalario salario) == unAnio) salarios

filtrarPorPeriodo :: Periodo -> [SalarioBasico] -> [SalarioBasico]
filtrarPorPeriodo unPeriodo salarios = filter (\salario -> periodoSalario salario == unPeriodo) salarios

sueldosDocente :: Docente -> Number -> [SalarioBasico] -> [SalarioBasico]
sueldosDocente docente unAnio salarios =
  filtrarPorAnio unAnio (filtrarPocategoriaSalario (categoriaDocente docente) (filtrarPodedicacionSalario (dedicacionDocente docente) salarios))

totalAnual :: Docente -> Number -> [SalarioBasico] -> Number
totalAnual docente unAnio salarios = sum (map valorSalario (sueldosDocente docente unAnio salarios))

sueldoEnPeriodo :: Docente -> Periodo -> [SalarioBasico] -> Number
sueldoEnPeriodo docente unPeriodo salarios =
  case (filtrarPorPeriodo unPeriodo (sueldosDocente docente (anio unPeriodo) salarios)) of
    (x:_) -> valorSalario x
    _ -> error $ "No hay valor para periodo " ++ show unPeriodo

ipcEn :: Periodo -> [Ipc] -> Number
ipcEn unPeriodo = valorIpc . head . filter (\ipc -> periodoIpc ipc == unPeriodo)

ajustadoPorIpc :: Number -> Periodo -> Periodo -> [Ipc] -> Number
ajustadoPorIpc unValor origen destino ipc = unValor * ipcEn destino ipc / ipcEn origen ipc

periodos2026 :: [Periodo]
periodos2026 = map (\anio -> UnPeriodo anio 2026) [Enero .. Diciembre]

ajustarSueldoA2026 :: SalarioBasico -> [Ipc] -> [Number]
ajustarSueldoA2026 salario valoresIpc =
  map (\periodo -> ajustadoPorIpc (valorSalario salario) (periodoSalario salario) periodo valoresIpc) periodos2026

diferenciaPorValor :: Number -> Number -> Number
diferenciaPorValor real ajustado = real - ajustado

diferenciaPorPorcentaje :: Number -> Number -> Number
diferenciaPorPorcentaje real ajustado = (real - ajustado) / real

comparativaPorValor :: Docente -> Periodo -> Periodo -> [SalarioBasico] -> [Ipc] -> Number
comparativaPorValor docente periodoReferencia periodoDestino salarios valoresIpc =
  let sueldoReal = sueldoEnPeriodo docente periodoDestino salarios
      sueldoAjustado = ajustadoPorIpc (sueldoEnPeriodo docente periodoReferencia salarios) periodoReferencia periodoDestino valoresIpc
  in diferenciaPorValor sueldoReal sueldoAjustado

comparativaPorPorcentaje :: Docente -> Periodo -> Periodo -> [SalarioBasico] -> [Ipc] -> Number
comparativaPorPorcentaje docente periodoReferencia periodoDestino salarios valoresIpc =
  let sueldoReal = sueldoEnPeriodo docente periodoDestino salarios
      sueldoAjustado = ajustadoPorIpc (sueldoEnPeriodo docente periodoReferencia salarios) periodoReferencia periodoDestino valoresIpc
  in diferenciaPorPorcentaje sueldoReal sueldoAjustado

hayAlgunMesEnElQueMejora :: Docente -> Periodo -> [SalarioBasico] -> [Ipc] -> Bool
hayAlgunMesEnElQueMejora docente periodoReferencia salarios ipc =
  any (\periodo -> comparativaPorValor docente periodoReferencia periodo salarios ipc > 0) periodos2026

todosCobranMenosQueLoQueDeberian :: [Docente] -> Periodo -> Periodo -> [SalarioBasico] -> [Ipc] -> Bool
todosCobranMenosQueLoQueDeberian docentes periodoReferencia periodoObjetivo salarios valoresIpc =
  all (\docente -> comparativaPorValor docente periodoReferencia periodoObjetivo salarios valoresIpc < 0) docentes

periodosDesdeOct2025 :: [Periodo]
periodosDesdeOct2025 =
  map (\mes -> UnPeriodo mes 2025 ) [Octubre .. Diciembre] ++ map (\mes -> UnPeriodo mes 2026 ) [Enero .. Marzo]

perdidaAcumulada :: Docente -> Periodo -> [SalarioBasico] -> [Ipc] -> Number
perdidaAcumulada docente periodoReferencia salarios valoresIpc =
  sum (map (\periodo -> comparativaPorValor docente periodoReferencia periodo salarios valoresIpc) periodosDesdeOct2025)

perdidaAcumuladaEnCantidadDeSueldos :: Docente -> Periodo -> Periodo -> [SalarioBasico] -> [Ipc] -> Number
perdidaAcumuladaEnCantidadDeSueldos docente periodoReferencia periodoActual salarios valoresIpc =
  perdidaAcumulada docente periodoReferencia salarios valoresIpc / sueldoEnPeriodo docente periodoActual salarios
