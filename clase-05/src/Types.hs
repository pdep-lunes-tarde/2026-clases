module Types where
import PdePreludat

data Mes = Enero | Febrero | Marzo | Abril | Mayo | Junio | Julio | Agosto | Septiembre | Octubre | Noviembre | Diciembre
  deriving (Show, Eq, Ord, Enum)

data Periodo = UnPeriodo { anio :: Number, mes :: Mes } deriving (Show, Eq, Ord)

data Dedicacion = Exclusiva | Semiexclusiva | Simple deriving (Show, Eq)
data Categoria  = Titular | Asociado | Adjunto | JTP | AyudanteDe1era | AyudanteDe2da deriving (Show, Eq)

data SalarioBasico = SalarioBasico
  { dedicacionSalario :: Dedicacion
  , categoriaSalario  :: Categoria
  , periodoSalario     :: Periodo
  , valorSalario      :: Number
  } deriving (Show, Eq)

data Docente = UnDocente {
  nombreDocente :: String,
  categoriaDocente :: Categoria,
  dedicacionDocente :: Dedicacion
  } deriving (Show, Eq)

data Ipc = Ipc { periodoIpc :: Periodo, valorIpc :: Number } deriving (Show, Eq)
