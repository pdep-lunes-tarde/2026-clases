module Library where
import PdePreludat

type Condimento = String

data Hamburguesa = Hamburguesa {
  cantidadMedallones :: Number,
  precio :: Number,
  condimentos :: [Condimento],
  coccion :: Coccion
} deriving (Eq, Show)

data Coccion = AlVapor | Asada { minutos :: Number } | Frita { aceite :: Aceite } deriving (Eq, Show)

data Aceite = Girasol | Oliva | RecicladoDeMotor deriving (Eq, Show)

calorias :: Hamburguesa -> Number
calorias hamburguesa = cantidadMedallones hamburguesa * (100 + caloriasExtraPorCoccion (coccion hamburguesa))

caloriasExtraPorCoccion :: Coccion -> Number
caloriasExtraPorCoccion AlVapor = 0
caloriasExtraPorCoccion (Asada minutos) = 5 * minutos
caloriasExtraPorCoccion (Frita Girasol) = 50
caloriasExtraPorCoccion (Frita Oliva) = 30
caloriasExtraPorCoccion (Frita RecicladoDeMotor) = 200

cangreburgerClasica :: Hamburguesa
cangreburgerClasica = Hamburguesa {
  cantidadMedallones = 1,
  condimentos = [],
  precio = 10,
  coccion = Asada { minutos = 5 }
}

mcPatricio :: Hamburguesa
mcPatricio = Hamburguesa {
  cantidadMedallones = 2,
  condimentos = ["mostaza"],
  precio = 15,
  coccion = Frita RecicladoDeMotor
}

mcPatricioDeluxe :: Hamburguesa
mcPatricioDeluxe = conCoccion (Frita Oliva) . conPrecio (precio mcPatricio + 5) $ mcPatricio

cangreburguejaAlVapor :: Hamburguesa
cangreburguejaAlVapor = conCoccion AlVapor cangreburgerClasica

conPrecio :: Number -> Hamburguesa -> Hamburguesa
conPrecio nuevoPrecio hamburguesa = hamburguesa { precio = nuevoPrecio}

conCoccion :: Coccion -> Hamburguesa -> Hamburguesa
conCoccion nuevaCoccion hamburguesa = hamburguesa { coccion = nuevaCoccion }

cangreburgerDoble :: Hamburguesa
cangreburgerDoble = cangreburgerMultiple 2

cangreburgerTriple :: Hamburguesa
cangreburgerTriple = cangreburgerMultiple 3

cangreburgerMultiple :: Number -> Hamburguesa
cangreburgerMultiple n = cangreburgerClasica {
  cantidadMedallones = n,
  precio = precio cangreburgerClasica * n
}

con :: [Condimento] -> Hamburguesa -> Hamburguesa
con nuevosCondimentos hamburguesa = hamburguesa {
  condimentos = condimentos hamburguesa ++ nuevosCondimentos,
  precio = precio hamburguesa + precioPorCondimentosExtra nuevosCondimentos
}

precioPorCondimentosExtra :: [Condimento] -> Number
precioPorCondimentosExtra condimentosExtra = ((/2) . totalDeLetras) condimentosExtra

totalDeLetras :: [String] -> Number
totalDeLetras = sum . map length

estaCarbonizada :: Hamburguesa -> Bool
estaCarbonizada hamburguesa = seCocinoHastaCarbonizar (coccion hamburguesa)

seCocinoHastaCarbonizar :: Coccion -> Bool
seCocinoHastaCarbonizar (Asada minutos) = minutos > 10
seCocinoHastaCarbonizar (Frita RecicladoDeMotor) = True
seCocinoHastaCarbonizar _ = False

data Cliente = Cliente {
  presupuesto :: Number,
  leGusta :: Hamburguesa -> Bool,
  puntaje :: Hamburguesa -> Number
} deriving Show

patricio :: Cliente
patricio = Cliente {
  presupuesto = 20,
  leGusta = \hamburguesa -> True,
  puntaje = \hamburguesa ->
    cantidadMedallones hamburguesa + length (condimentos hamburguesa)
}

tiene :: Hamburguesa -> Condimento -> Bool
tiene hamburguesa condimento = elem condimento (condimentos hamburguesa)

arenita :: Cliente
arenita = Cliente {
  presupuesto = 50,
  leGusta = any esCondimentoFavoritoDeArenita . condimentos,
  puntaje = length . filter esCondimentoFavoritoDeArenita . condimentos
}

esCondimentoFavoritoDeArenita :: String -> Bool
esCondimentoFavoritoDeArenita condimento = elem condimento ["nueces", "almendras", "avellanas"]

robaloBurbuja :: Cliente
robaloBurbuja = Cliente {
  presupuesto = 30,
  leGusta = \hamburguesa ->
    cantidadMedallones hamburguesa == 6 &&
    all (tiene hamburguesa) [
      "guijarros extra con vibración exprimida",
      "eje con grasa ligera",
      "pepinillos"
    ] && fueAsadaPorAlMenos 8 (coccion hamburguesa),
  puntaje = \hamburguesa ->
    max 1 ((sqrt . totalDeLetras . condimentos) hamburguesa - precio hamburguesa)
}

fueAsadaPorAlMenos :: Number -> Coccion -> Bool
fueAsadaPorAlMenos tiempoMinimo (Asada minutos) = minutos >= tiempoMinimo
fueAsadaPorAlMenos _ _ = False

sardina :: Condimento -> Bool -> Cliente
sardina condimentoAlergeno estaADieta = Cliente {
  presupuesto = 15,
  leGusta = \hamburguesa ->
    not (tiene hamburguesa condimentoAlergeno) &&
    (not estaADieta || calorias hamburguesa < 300),
  puntaje = \hamburguesa ->
    100 * length (condimentos hamburguesa) / calorias hamburguesa
}

plankton :: Cliente
plankton = Cliente {
  presupuesto = 100,
  leGusta = \hamburguesa -> precio hamburguesa <= 10 || esFrita (coccion hamburguesa),
  puntaje = puntajePlankton
}

esFrita :: Coccion -> Bool
esFrita (Frita _) = True
esFrita _ = False

puntajePlankton :: Hamburguesa -> Number
puntajePlankton hamburguesa
  | tiene hamburguesa "La fórmula secreta de las cangreburgers" = 99999
  | otherwise = 1

type Menu = [Hamburguesa]

leGustan :: Cliente -> Menu -> [Hamburguesa]
leGustan cliente menu = filter (leGusta cliente) menu

leAlcanzaParaComprar :: Cliente -> Hamburguesa -> Bool
leAlcanzaParaComprar cliente hamburguesa =
  precio hamburguesa <= presupuesto cliente 

laCompraria :: Cliente -> Hamburguesa -> Bool
laCompraria cliente hamburguesa =
  leGusta cliente hamburguesa && leAlcanzaParaComprar cliente hamburguesa

comprariaAlguna :: Cliente -> Menu -> Bool
comprariaAlguna cliente = any (laCompraria cliente)

cualCompraria :: Cliente -> Menu -> Hamburguesa
cualCompraria cliente = maximoSegun (puntajeDe cliente) . filter (laCompraria cliente)

puntajeDe :: Cliente -> Hamburguesa -> Number
puntajeDe cliente hamburguesa
  | leGusta cliente hamburguesa = puntaje cliente hamburguesa
  | otherwise = 0

mayorSegun :: Ord b => (a -> b) -> a -> a -> a
mayorSegun criterio unValor otroValor
  | criterio unValor >= criterio otroValor = unValor
  | otherwise = otroValor

maximoSegun :: Ord b => (a -> b) -> [a] -> a
maximoSegun criterio = foldl1 (mayorSegun criterio)

data Empleado = Empleado { salarioDiario :: Number }

data CrustaceoCascarudo = CrustaceoCascarudo {
  empleados :: [Empleado],
  menu :: Menu,
  dinero :: Number
}

bobEsponja :: Empleado
bobEsponja = Empleado { salarioDiario = 5 }
calamardo :: Empleado
calamardo = Empleado { salarioDiario = 7 }

crustaceoCascarudo :: CrustaceoCascarudo
crustaceoCascarudo = CrustaceoCascarudo {
  empleados = [bobEsponja, calamardo],
  menu = [cangreburgerClasica, mcPatricio, con ["mayonesa"] $ cangreburgerMultiple 5],
  dinero = 5
}

vender :: Hamburguesa -> CrustaceoCascarudo -> CrustaceoCascarudo
vender hamburguesa = aumentarDinero (precio hamburguesa)

aumentarDinero :: Number -> CrustaceoCascarudo -> CrustaceoCascarudo
aumentarDinero cantidad crustaceoCascarudo = crustaceoCascarudo {
  dinero = dinero crustaceoCascarudo + cantidad
}

disminuirDinero :: Number -> CrustaceoCascarudo -> CrustaceoCascarudo
disminuirDinero cantidad crustaceoCascarudo = crustaceoCascarudo {
  dinero = dinero crustaceoCascarudo - cantidad
}

atender :: Cliente -> CrustaceoCascarudo -> CrustaceoCascarudo
atender cliente crustaceoCascarudo
  | comprariaAlguna cliente (menu crustaceoCascarudo) =
    vender (cualCompraria cliente (menu crustaceoCascarudo)) crustaceoCascarudo
  | otherwise = crustaceoCascarudo

aAlguienLaCompraria :: [Cliente] -> Hamburguesa -> Bool
aAlguienLaCompraria clientes hamburguesa = any (\cliente -> laCompraria cliente hamburguesa) clientes

elMenuFueUnExito :: [Cliente] -> CrustaceoCascarudo -> Bool
elMenuFueUnExito clientes crustaceoCascarudo =
  (all (aAlguienLaCompraria clientes) . menu) crustaceoCascarudo

pasarUnDiaDeTrabajo :: [Cliente] -> CrustaceoCascarudo -> CrustaceoCascarudo
pasarUnDiaDeTrabajo clientes crustaceoCascarudo =
  (pagarExtraSiElMenuFueUnExito clientes . pagarSueldos . atenderATodos clientes) crustaceoCascarudo

atenderATodos :: [Cliente] -> CrustaceoCascarudo -> CrustaceoCascarudo
atenderATodos clientes crustaceoCascarudo = foldr atender crustaceoCascarudo clientes

sueldosBaseDiariosTotales :: CrustaceoCascarudo -> Number
sueldosBaseDiariosTotales = sum . map salarioDiario . empleados

pagarSueldos :: CrustaceoCascarudo -> CrustaceoCascarudo
pagarSueldos crustaceoCascarudo =
  disminuirDinero (sueldosBaseDiariosTotales crustaceoCascarudo) crustaceoCascarudo

pagarExtraSiElMenuFueUnExito :: [Cliente] -> CrustaceoCascarudo -> CrustaceoCascarudo
pagarExtraSiElMenuFueUnExito clientes crustaceoCascarudo
  | elMenuFueUnExito clientes crustaceoCascarudo =
    disminuirDinero (length (empleados crustaceoCascarudo)) crustaceoCascarudo
  | otherwise =
    crustaceoCascarudo
