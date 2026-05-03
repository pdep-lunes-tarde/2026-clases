module Library where
import PdePreludat

data Periodo = UnPeriodo { mes :: Mes, anio :: Number } deriving (Show, Eq)

data Mes = Enero | Febrero | Marzo | Abril | Mayo | Junio | Julio | Agosto | Septiembre | Octubre | Noviembre | Diciembre deriving (Show, Eq, Enum)
data Dedicacion = Exclusiva | Semiexclusiva | Simple deriving (Show, Eq)
data Categoria  = Titular | Asociado | Adjunto | JTP | AyudanteUno | AyudanteDos deriving (Show, Eq)

data RegistroSueldo = RegistroSueldo
  { rDedicacion :: Dedicacion
  , rCategoria  :: Categoria
  , periodo :: Periodo
  , rValor      :: Number
  } deriving (Show, Eq)

data Docente = Docente
  { dNombre     :: String
  , dCategoria  :: Categoria
  , dDedicacion :: Dedicacion
  } deriving (Show, Eq)

juan :: Docente
juan = Docente { dNombre = "Juan", dCategoria = Adjunto, dDedicacion = Simple }

tomas :: Docente
tomas = Docente { dNombre = "Tomás", dCategoria = JTP, dDedicacion = Simple }

lucas :: Docente
lucas = Docente { dNombre = "Lucas", dCategoria = Titular, dDedicacion = Exclusiva }

data Ipc = Ipc { periodoIpc :: Periodo, valor :: Number }

datosIpc :: [Ipc]
datosIpc = [Ipc (UnPeriodo Enero 2016) 100]

valorIpc :: Periodo -> Number
valorIpc p = valor (head (filter (\ipc -> periodoIpc ipc == p) datosIpc))

mkRegistros :: Number -> [String] -> [(Dedicacion, Categoria, [Number])] -> [RegistroSueldo]
mkRegistros anio meses datos = implementame

salarios2025 :: [RegistroSueldo]
salarios2025 = mkRegistros 2025
  ["enero", "febrero", "marzo", "abril", "mayo"]
  [ (Exclusiva,    Titular,     [1262025.73, 1277170.03, 1293773.24, 1310592.29, 1327629.98])
  , (Exclusiva,    Asociado,    [1123020.19, 1136496.43, 1151270.88, 1166237.40, 1181398.48])
  , (Exclusiva,    Adjunto,     [984505.76,  996319.82,  1009271.97, 1022392.50, 1035683.60])
  , (Exclusiva,    JTP,         [845496.42,  855642.37,  866765.72,  878033.67,  889448.10])
  , (Exclusiva,    AyudanteUno, [706344.71,  714820.84,  724113.51,  733526.98,  743062.83])
  , (Semiexclusiva,Titular,     [631013.96,  638586.12,  646887.73,  655297.27,  663816.13])
  , (Semiexclusiva,Asociado,    [561509.28,  568247.39,  575634.60,  583117.84,  590698.37])
  , (Semiexclusiva,Adjunto,     [492248.56,  498155.54,  504631.56,  511191.77,  517837.26])
  , (Semiexclusiva,JTP,         [422747.65,  427820.62,  433382.28,  439016.24,  444723.45])
  , (Semiexclusiva,AyudanteUno, [353171.32,  357409.37,  362055.69,  366762.41,  371530.32])
  , (Simple,       Titular,     [315506.16,  319292.23,  323443.02,  327647.77,  331907.19])
  , (Simple,       Asociado,    [280750.82,  284119.82,  287813.37,  291554.94,  295345.15])
  , (Simple,       Adjunto,     [246121.81,  249075.27,  252313.24,  255593.31,  258916.02])
  , (Simple,       JTP,         [211371.37,  213907.82,  216688.62,  219505.57,  222359.14])
  , (Simple,       AyudanteUno, [176582.55,  178701.54,  181024.66,  183377.98,  185761.89])
  , (Simple,       AyudanteDos, [141268.33,  142963.54,  144822.06,  146704.74,  148611.90])
  ]

salarios2024 :: [RegistroSueldo]
salarios2024 = mkRegistros 2024
  ["febrero", "marzo", "abril", "mayo", "junio", "julio", "agosto", "septiembre", "octubre", "noviembre", "diciembre"]
  [ (Exclusiva,    Titular,     [729732.92,  817299.92,  882682.92,  962123.92,  1000607.92, 1075653.51, 1107923.11, 1130081.57, 1206927.11, 1231065.11, 1243375.11])
  , (Exclusiva,    Asociado,    [649355.56,  727277.56,  785459.56,  856150.56,  890396.56,  957176.30,  985891.58,  1005609.41, 1073990.84, 1095469.84, 1106423.84])
  , (Exclusiva,    Adjunto,     [569263.90,  637574.90,  688579.90,  750551.90,  780573.90,  839116.94,  864290.44,  881576.24,  941523.42,  960353.42,  969956.42])
  , (Exclusiva,    JTP,         [488885.43,  547551.43,  591355.43,  644576.43,  670359.43,  720636.38,  742255.47,  757100.57,  808583.40,  824754.40,  833001.40])
  , (Exclusiva,    AyudanteUno, [408425.16,  457436.16,  494030.16,  538492.16,  560031.16,  602033.49,  620094.49,  632496.37,  675506.12,  689016.12,  695906.12])
  , (Semiexclusiva,Titular,     [364866.86,  408650.86,  441342.86,  481062.86,  500304.86,  537827.72,  553962.55,  565041.80,  603464.64,  615533.64,  621688.64])
  , (Semiexclusiva,Asociado,    [324678.03,  363639.03,  392730.03,  428075.03,  445198.03,  478587.88,  492945.51,  502804.42,  536995.12,  547734.12,  553211.12])
  , (Semiexclusiva,Adjunto,     [284631.85,  318786.85,  344288.85,  375273.85,  390283.85,  419555.13,  432141.78,  440784.61,  470757.96,  480172.96,  484973.96])
  , (Semiexclusiva,JTP,         [244443.10,  273776.10,  295678.10,  322289.10,  335180.10,  360318.60,  371128.15,  378550.71,  404292.15,  412377.15,  416500.15])
  , (Semiexclusiva,AyudanteUno, [204212.74,  228717.74,  247014.74,  269245.74,  280014.74,  301015.84,  310046.31,  316247.23,  337752.04,  344507.04,  347952.04])
  , (Simple,       Titular,     [182433.60,  204325.60,  220671.60,  240531.60,  250152.60,  268914.04,  276981.46,  282521.08,  301732.51,  307766.51,  310843.51])
  , (Simple,       Asociado,    [162338.74,  181818.74,  196363.74,  214035.74,  222596.74,  239291.49,  246470.23,  251399.63,  268494.80,  273863.80,  276601.80])
  , (Simple,       Adjunto,     [142315.75,  159392.75,  172143.75,  187635.75,  195140.75,  209776.30,  216069.58,  220390.97,  235377.55,  240084.55,  242484.55])
  , (Simple,       JTP,         [122221.88,  136887.88,  147838.88,  161143.88,  167588.88,  180158.04,  185562.78,  189274.03,  202144.66,  206186.66,  208247.66])
  , (Simple,       AyudanteUno, [102106.67,  114358.67,  123506.67,  134621.67,  140005.67,  150506.09,  155021.27,  158121.69,  168873.96,  172250.96,  173972.96])
  , (Simple,       AyudanteDos, [81685.75,   91487.75,   98806.75,   107698.75,  112005.75,  120406.18,  124018.36,  126498.72,  135100.63,  137802.63,  139180.63])
  ]

salarios2023 :: [RegistroSueldo]
salarios2023 = mkRegistros 2023
  ["enero", "febrero", "marzo", "abril", "mayo", "junio", "julio", "agosto", "septiembre", "octubre", "noviembre", "diciembre"]
  [ (Exclusiva,    Titular,     [241812.51, 246957.46, 293632.44, 313882.96, 338942.98, 366058.42, 406731.58, 444015.31, 488416.85, 547026.88, 596259.30, 629080.92])
  , (Exclusiva,    Asociado,    [215177.59, 219755.84, 261289.71, 279309.69, 301609.43, 325738.19, 361931.33, 395108.37, 434619.21, 486773.52, 530583.14, 559789.56])
  , (Exclusiva,    Adjunto,     [188637.49, 192651.06, 229062.13, 244859.52, 264408.80, 285561.51, 317290.57, 346375.54, 381013.10, 426734.68, 465140.81, 490744.90])
  , (Exclusiva,    JTP,         [162002.51, 165449.38, 196719.34, 210286.20, 227075.19, 245241.21, 272490.24, 297468.52, 327215.38, 366481.23, 399464.55, 421453.43])
  , (Exclusiva,    AyudanteUno, [135340.35, 138219.94, 164343.53, 175677.57, 189703.45, 204879.73, 227644.15, 248511.53, 273362.69, 306166.22, 333721.18, 352091.16])
  , (Semiexclusiva,Titular,     [120906.39, 123478.87, 146816.39, 156941.66, 169471.69, 183029.43, 203366.04, 222007.93, 244208.73, 273513.78, 298130.03, 314540.86])
  , (Semiexclusiva,Asociado,    [107588.87, 109878.00, 130644.96, 139654.96, 150804.84, 162869.23, 180965.82, 197554.36, 217309.80, 243386.98, 265291.81, 279895.03])
  , (Semiexclusiva,Adjunto,     [94318.88,  96325.67,  114531.24, 122429.95, 132204.60, 142780.97, 158645.53, 173188.04, 190506.85, 213367.68, 232570.78, 245372.85])
  , (Semiexclusiva,JTP,         [81001.40,  82724.84,  98359.85,  105143.29, 113537.80, 122620.83, 136245.37, 148734.53, 163607.99, 183240.95, 199732.64, 210727.10])
  , (Semiexclusiva,AyudanteUno, [67670.21,  69110.01,  82171.82,  87838.85,  94851.80,  102439.95, 113822.17, 124255.87, 136681.46, 153083.24, 166860.74, 176045.74])
  , (Simple,       Titular,     [60453.25,  61739.49,  73408.26,  78470.90,  84735.92,  91514.80,  101683.12, 111004.08, 122104.49, 136757.03, 149065.17, 157270.60])
  , (Simple,       Asociado,    [53794.49,  54939.06,  65322.56,  69827.57,  75402.52,  81434.73,  90483.04,  98777.32,  108655.06, 121693.67, 132646.11, 139947.74])
  , (Simple,       Adjunto,     [47159.53,  48162.93,  57265.74,  61215.11,  66102.46,  71390.66,  79322.96,  86594.24,  95253.67,  106684.12, 116285.70, 122686.75])
  , (Simple,       JTP,         [40500.83,  41362.55,  49180.08,  52571.81,  56769.08,  61310.61,  68122.90,  74367.50,  81804.25,  91620.76,  99866.63,  105363.88])
  , (Simple,       AyudanteUno, [33835.39,  34555.30,  41086.28,  43919.82,  47426.33,  51220.44,  56911.60,  62128.50,  68341.35,  76542.32,  83431.13,  88023.67])
  , (Simple,       AyudanteDos, [27068.23,  27644.15,  32868.91,  35135.74,  37940.94,  40976.22,  45529.14,  49702.65,  54672.92,  61233.68,  66744.72,  70418.75])
  ]

salarios2022 :: [RegistroSueldo]
salarios2022 = mkRegistros 2022
  ["enero", "febrero", "marzo", "junio", "julio", "agosto", "septiembre", "octubre", "noviembre", "diciembre"]
  [ (Exclusiva,    Titular,     [119376.18, 126101.61, 145344.73, 165924.52, 181359.36, 190363.02, 196794.21, 208370.34, 217374.00, 239240.03])
  , (Exclusiva,    Asociado,    [106227.26, 112211.90, 129335.44, 147648.43, 161383.17, 169395.10, 175117.91, 185418.97, 193430.90, 212888.46])
  , (Exclusiva,    Adjunto,     [93125.12,  98371.62,  113383.14, 129437.39, 141478.08, 148501.82, 153518.78, 162549.30, 169573.04, 186630.70])
  , (Exclusiva,    JTP,         [79976.16,  84481.87,  97373.81,  111161.26, 121501.85, 127533.86, 131842.44, 139597.88, 145629.89, 160279.07])
  , (Exclusiva,    AyudanteUno, [66813.79,  70577.95,  81348.15,  92866.48,  101505.23, 106544.50, 110143.98, 116623.04, 121662.31, 133900.55])
  , (Semiexclusiva,Titular,     [59688.14,  63050.86,  72672.43,  82962.34,  90679.77,  95181.61,  98397.21,  104185.28, 108687.12, 119620.15])
  , (Semiexclusiva,Asociado,    [53113.65,  56105.97,  64667.75,  73824.25,  80691.63,  84697.60,  87559.01,  92709.54,  96715.51,  106444.30])
  , (Semiexclusiva,Adjunto,     [46562.61,  49185.86,  56691.63,  64718.77,  70739.12,  74251.00,  76759.48,  81274.75,  84786.63,  93315.48])
  , (Semiexclusiva,JTP,         [39988.14,  42241.00,  48686.98,  55580.72,  60751.02,  63767.03,  65921.33,  69799.06,  72815.07,  80139.68])
  , (Semiexclusiva,AyudanteUno, [33406.90,  35288.98,  40674.08,  46433.25,  50752.63,  53272.27,  55072.01,  58311.54,  60831.18,  66950.31])
  , (Simple,       Titular,     [29844.10,  31525.46,  36336.25,  41481.21,  45339.93,  47590.85,  49198.65,  52092.69,  54343.61,  59810.13])
  , (Simple,       Asociado,    [26556.84,  28053.00,  32333.89,  36912.14,  40345.83,  42348.82,  43779.53,  46354.80,  48357.79,  53222.20])
  , (Simple,       Adjunto,     [23281.34,  24592.97,  28345.86,  32359.44,  35369.62,  37125.56,  38379.81,  40637.45,  42393.39,  46657.83])
  , (Simple,       JTP,         [19994.13,  21120.57,  24343.58,  27790.46,  30375.62,  31883.63,  32960.78,  34899.65,  36407.66,  40069.97])
  , (Simple,       AyudanteUno, [16703.55,  17644.61,  20337.19,  23216.80,  25376.51,  26636.34,  27536.22,  29156.00,  30415.83,  33475.43])
  , (Simple,       AyudanteDos, [13362.82,  14115.67,  16269.73,  18573.41,  20301.17,  21309.03,  22028.93,  23324.75,  24332.61,  26780.27])
  ]

salarios :: [RegistroSueldo]
salarios = salarios2022 ++ salarios2023 ++ salarios2024 ++ salarios2025

filtrarPorCategoria :: Categoria -> [RegistroSueldo] -> [RegistroSueldo]
filtrarPorCategoria unaCategoria registros = filter (\registro -> rCategoria registro == unaCategoria) registros

filtrarPorDedicacion :: Dedicacion -> [RegistroSueldo] -> [RegistroSueldo]
filtrarPorDedicacion unaDedicacion registros = filter (\registro -> rDedicacion registro == unaDedicacion) registros

filtrarPorAnio :: Number -> [RegistroSueldo] -> [RegistroSueldo]
filtrarPorAnio unAnio registros = filter (\registro -> anio (periodo registro) == unAnio) registros

filtrarPorPeriodo :: Periodo -> [RegistroSueldo] -> [RegistroSueldo]
filtrarPorPeriodo unPeriodo registros = filter (\registro -> periodo registro == unPeriodo) registros

sueldosDocente :: Docente -> Number -> [RegistroSueldo]
sueldosDocente docente anio =
  filtrarPorAnio anio (filtrarPorCategoria  (dCategoria  docente) (filtrarPorDedicacion (dDedicacion docente) salarios))

totalAnual :: Docente -> Number -> Number
totalAnual docente anio = sum (map rValor (sueldosDocente docente anio))

sueldoEnPeriodo :: Docente -> Periodo -> Number
sueldoEnPeriodo docente periodo =
  rValor (head (filtrarPorPeriodo periodo (sueldosDocente docente (anio periodo))))

ajustadoPorIpc :: Number -> Periodo -> Periodo -> Number
ajustadoPorIpc valor origen destino = valor * valorIpc destino / valorIpc origen

periodos2026 :: [Periodo]
periodos2026 = map (\mes -> UnPeriodo mes 2026) [Enero .. Diciembre]

ajustarSueldoA2026 :: RegistroSueldo -> [(Periodo, Number)]
ajustarSueldoA2026 registro =
  map (\p -> (p, ajustadoPorIpc (rValor registro) (rAnio registro, rMes registro) p)) periodos2026

-- =============================================================================
-- Comparativas
-- =============================================================================

diferenciaPorValor :: Number -> Number -> Number
diferenciaPorValor real ajustado = real - ajustado

diferenciaPorPorcentaje :: Number -> Number -> Number
diferenciaPorPorcentaje real ajustado = (real - ajustado) / real

comparativaPorValor :: Docente -> Periodo -> Periodo -> Number
comparativaPorValor docente periodoRef periodoDestino =
  diferenciaPorValor real ajustado
  where
    real     = sueldoEnPeriodo docente periodoDestino
    ajustado = ajustadoPorIpc (sueldoEnPeriodo docente periodoRef) periodoRef periodoDestino

comparativaPorPorcentaje :: Docente -> Periodo -> Periodo -> Number
comparativaPorPorcentaje docente periodoRef periodoDestino =
  diferenciaPorPorcentaje real ajustado
  where
    real     = sueldoEnPeriodo docente periodoDestino
    ajustado = ajustadoPorIpc (sueldoEnPeriodo docente periodoRef) periodoRef periodoDestino

hayMesMejor :: Docente -> Periodo -> Bool
hayMesMejor docente periodoRef =
  any (\p -> comparativaPorValor docente periodoRef p > 0) periodos2026

todosMenorAjustado :: [Docente] -> Periodo -> Periodo -> Bool
todosMenorAjustado docentes periodoRef periodoObj =
  all (\d -> comparativaPorValor d periodoRef periodoObj < 0) docentes

-- =============================================================================
-- Pérdida acumulada
-- =============================================================================

periodosDesdeOct2025 :: [Periodo]
periodosDesdeOct2025 = map fst . filter esPeriodoRelevante $ datosIpc
  where
    esPeriodoRelevante ((anio, mes), _) =
      anio == 2026 ||
      (anio == 2025 && mes `elem` ["octubre", "noviembre", "diciembre"])

perdidaAcumulada :: Docente -> Periodo -> Number
perdidaAcumulada docente periodoRef =
  sum . map (comparativaPorValor docente periodoRef) $ periodosDesdeOct2025

cuantosSueldosEquivale :: Docente -> Periodo -> Number -> Number
cuantosSueldosEquivale docente periodoActual perdida =
  perdida / sueldoEnPeriodo docente periodoActual
