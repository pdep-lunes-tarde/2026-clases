{-# LANGUAGE StandaloneDeriving #-}
{-# LANGUAGE DerivingVia #-}
module CargarDatos where
import PdePreludat
import Types
import Prelude (readFile, read, lines, Rational, Double)
import qualified Redefinitions as SalarioBasico
import GHC.IO (unsafePerformIO)

-- Hay comentarios explicando cosas que no se ven en la materia que son relevantes para entender este código.

-- IO es un tipo que significa que el valorIpc es una acción de Entrada/Salida (como leer o escribir a un archivo)
-- IO, al igual que las listas es un tipo que "envuelve" a otro, porque una operación de entrada salida podría
-- llevar consigo un resultado de cualquier tipo.
-- En este caso, se hacen varias acciones de leer distintos archivos (por eso el IO) y se obtiene una lista de SalarioBasico,
-- por eso el tipo de este valorIpc es IO [SalarioBasico].
-- La sintaxis:
--
--     do
--  valorIpc <- accionConIO
--  return valorIpc
-- 
-- es syntax sugar de haskell para ciertas funciones de haskell que permiten manipular los (IO a) para poder usar esos (a) que llevan consigo.
-- Las reglas son:
-- a la derecha del <- tiene que haber una expresión de tipo IO a
-- a la izquierda del <- podemos introducir una constante de tipo a, y se va a ligar a lo que se obtenga del IO de la derecha.
-- Diferentes líneas podrían ligar constantes de diferentes tipos, pero en este caso cada línea liga algo de tipo [RegistroSalario].
-- las operaciones se resuelven en orden de arriba para abajo, así que en una línea de más abajo podemos referenciar lo ligado más arriba
-- (similar a cualquier programa del paradigma imperativo)
-- la última línea tiene que ser de tipo IO b (es decir, no necesariamente tiene que ser del mismo tipo de lo que obtuvimos en alguna de las líneas anteriores)
-- return es una función que dado un a devuelve un IO a.
cargarTodosSalarios :: IO [SalarioBasico]
cargarTodosSalarios = do
  salarios2022 <- cargarSalarios 2022 "datos/salarios_2022.csv"
  salarios2023 <- cargarSalarios 2023 "datos/salarios_2023.csv"
  salarios2024 <- cargarSalarios 2024 "datos/salarios_2024.csv"
  salarios2025 <- cargarSalarios 2025 "datos/salarios_2025.csv"
  salarios2026 <- cargarSalarios 2026 "datos/salarios_2026.csv"
  return (salarios2022 ++ salarios2023 ++ salarios2024 ++ salarios2025 ++ salarios2026)

-- FilePath es un type alias de String
cargarSalarios :: Number -> FilePath -> IO [SalarioBasico]
cargarSalarios anio archivo = do
  -- readFile dado una ruta a un archivo devuelve el texto del archivo como un String (más precisamente IO String), y al ligarlo con <- contenido es de tipo String.
  contenido <- readFile archivo

  -- let se usa para definir constantes que se definen sin usar IO, es como definir variables locales dentro de una función en otro lenguaje
  -- lines parte un String cada vez que hay un salto de línea (\n), devolviendo una lista
  let (encabezado : datos) = lines contenido
      meses = map parseMesHeader (drop 2 (separarPor ',' encabezado))

  return (concat (map (parsearFilaSalario anio meses) datos))

------
-- Funciones auxiliares para parsear (convertir el texto de String a valores de tipos que nos sirvan para algo)
------

-- >>> separarPor ' ' "hola mundo"
-- ["hola","mundo"]
separarPor :: Char -> String -> [String]
separarPor _ "" = [""]
separarPor delimitador (c:cs)
  | c == delimitador = "" : (separarPor delimitador cs)
  | otherwise  = (c : head (separarPor delimitador cs)) : tail (separarPor delimitador cs)

parseDedicacion :: String -> Dedicacion
parseDedicacion "exclusiva"     = Exclusiva
parseDedicacion "semiexclusiva" = Semiexclusiva
parseDedicacion "simple"        = Simple

parseCategoria :: String -> Categoria
parseCategoria "Titular"          = Titular
parseCategoria "Asociado"         = Asociado
parseCategoria "Adjunto"          = Adjunto
parseCategoria "JTP"              = JTP
parseCategoria "Ayudante de 1era" = AyudanteDe1era
parseCategoria "Ayudante de 2da"  = AyudanteDe2da

-- Esta es una sintaxis alternativa para hacer pattern matching,
-- dejo la forma conocida en las funciones anteriores para poder comparar.
parseMesHeader :: String -> Mes
parseMesHeader mes = case mes of
  "ENERO"       -> Enero
  "FEBRERO"    -> Febrero
  "MARZO"      -> Marzo
  "ABRIL"      -> Abril
  "MAYO"       -> Mayo
  "JUNIO"      -> Junio
  "JULIO"      -> Julio
  "AGOSTO"     -> Agosto
  "SEPTIEMBRE" -> Septiembre
  "OCTUBRE"    -> Octubre
  "NOVIEMBRE"  -> Noviembre
  "DICIEMBRE"  -> Diciembre
  x -> error $ "que es " ++ show x

-- Una fila de salario en los archivos que estamos usando como datos se ve así:
-- dedicacion,categoria,sueldoEnero,sueldoFebrero,sueldoMarzo,...etc
-- ejemplo:
-- simple,Ayudante de 2da,27068.23,27644.15,32868.91,35135.74,37940.94,40976.22,45529.14,49702.65,54672.92,61233.68,66744.72,70418.75
parsearFilaSalario :: Number -> [Mes] -> String -> [SalarioBasico]
parsearFilaSalario anio meses fila =
  -- let me deja introducir constantes que solo existen en el contexto de esta función
  let (textoDedicacion : textoCategoria : textoValores) = separarPor ',' fila
      dedicacion    = parseDedicacion textoDedicacion
      categoria    = parseCategoria textoCategoria
      valores   = map parseNumber textoValores
  -- zipWith toma dos listas y las opera elemento a elemento con una función
  -- ejemplo: zipWith (+) [1,2,3] [4,5,6] da [5,7,9]. En este caso se está usando
  -- para dados todos los meses y la lista de valores de sueldo por cada mes, generar un SalarioBasico.
  in zipWith (\mes valorIpc -> SalarioBasico {
    dedicacionSalario = dedicacion,
    categoriaSalario = categoria,
    periodoSalario = (UnPeriodo { mes = mes, anio = anio }),
    valorSalario = valorIpc
    }) meses valores

parseMesAbreviado :: String -> Mes
parseMesAbreviado "ene"  = Enero
parseMesAbreviado "feb"  = Febrero
parseMesAbreviado "mar"  = Marzo
parseMesAbreviado "abr"  = Abril
parseMesAbreviado "may"  = Mayo
parseMesAbreviado "jun"  = Junio
parseMesAbreviado "jul"  = Julio
parseMesAbreviado "ago"  = Agosto
parseMesAbreviado "sep" = Septiembre
parseMesAbreviado "oct"  = Octubre
parseMesAbreviado "nov"  = Noviembre
parseMesAbreviado "dic"  = Diciembre

parseNumber :: String -> Number
-- read es una función de haskell que ya sabe convertir String a diferentes tipos (falla si no se puede).
-- fromReal nos deja convertir ciertos tipos (Float, Double y algunos más) a Number, que es lo que usamos en el PdePreludat.
parseNumber text = fromReal (read text :: Double)

-- esto parsea cada uno de los "ene-16", "ago-22", etc que hay en el csv de
-- los valores del ipc, representan el mes y año al que corresponde cada número.
parsePeriodoIpc :: String -> Periodo
parsePeriodoIpc mesAnioComoTexto =
  -- let también se puede usar en funciones que no tienen la sintaxis de do y <-
  -- solo que acá se usa así:
  --
  -- let valorIpc = definición
  --     otroValor = otraDefinicion
  -- in expresion
  --
  -- e incluso se puede usar pattern matching, como acá:
  let [mesTexto, anioTexto] = separarPor '-' mesAnioComoTexto
  in UnPeriodo (parseMesAbreviado mesTexto) (parseNumber anioTexto + 2000)

cargarIpc :: IO [Ipc]
cargarIpc = do
  contenido <- readFile "datos/indice-ipc.csv"

  -- solo tiene 2 filas, la primera con los periodos y la segunda con los valores
  -- así que podemos directamente pattern matchear a una lista de 2 elementos
  let [encabezado, datos] = lines contenido
      periodos = map parsePeriodoIpc (separarPor ',' encabezado)
      valores = map parseNumber (separarPor ',' datos)

  return (zipWith Ipc periodos valores)

------

salariosCargados :: [SalarioBasico]
salariosCargados = unsafePerformIO cargarTodosSalarios

valoresIpcCargados :: [Ipc]
valoresIpcCargados = unsafePerformIO cargarIpc
