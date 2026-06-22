-- SOLUCION EN PARADIGMA FUNCIONAL --

module Library where
import PdePreludat
import Test.Hspec

-- Queremos poder contesar algunas cosas sobre
-- los países que juegan la fase de grupos del mundial como, ¿es cierto que Algeria está en el grupo J?

-- En el grupo J están Argentina, Algeria, Austria y Jordania.
-- En el grupo A están México, Sudáfrica, Corea del Sur y República Checa.
-- Chile no está en ningún grupo.

type Pais = String
data Grupo = Grupo { nombre :: String, paises :: [Pais] } deriving (Eq, Show)

grupoJ :: Grupo
grupoJ = Grupo "j" ["Argentina", "Algeria", "Austria", "Jordania"]
grupoA :: Grupo
grupoA = Grupo "a" ["Mexico", "Sudafrica", "Corea del Sur", "Republica Checa"]

grupos :: [Grupo]
grupos = [grupoA, grupoJ]

estaEnGrupo :: Pais -> Grupo -> Bool
estaEnGrupo unPais unGrupo = elem unPais (paises unGrupo)


-- ¿Y cómo podríamos preguntar en qué grupo está Sudáfrica?

grupoEnElQueEsta :: Pais -> Grupo
grupoEnElQueEsta unPais = head $ filter (estaEnGrupo unPais) grupos

-- ¿Y cómo podríamos preguntar qué paises están en el grupo A?
-- ya existe, es la funcion paises

-- ¿Cómo podríamos preguntar si un país está en el mundial?, esto es verdad si pertenece a algún grupo.

estaEnElMundial :: Pais -> Bool
estaEnElMundial unPais = any (estaEnGrupo unPais) grupos

-- Queremos saber si un pais A juega contra un pais B.

juegaContra :: Pais -> Pais -> Bool
juegaContra unPais otroPais =
  grupoEnElQueEsta unPais == grupoEnElQueEsta otroPais &&
  unPais /= otroPais

-- Además, queremos saber cuáles son los países contra los que juega un pais.

paisesContraLosQueJuega :: Pais -> [Pais]
paisesContraLosQueJuega unPais =
  filter (juegaContra unPais) . concatMap paises $ grupos


correrTests :: IO ()
correrTests = hspec $ do
  describe "Grupos" $ do
    it "un pais esta en un grupo si es parte de los paises de ese grupo" $ do
      estaEnGrupo "Algeria" grupoJ `shouldBe` True
    it "un pais no esta en un grupo si no es parte de los paises de ese grupo" $ do
      estaEnGrupo "Mexico" grupoJ `shouldBe` False
    it "el grupo en el que esta un pais es aquel grupo que lo tiene en su lista de paises" $ do
      grupoEnElQueEsta "Sudafrica" `shouldBe` grupoA
    it "un pais esta en el mundial si hay algun grupo al que pertenece" $ do
      estaEnElMundial "Algeria" `shouldBe` True
    it "un pais NO esta en el mundial si no hay ningun grupo al que pertenece" $ do
      estaEnElMundial "Chile" `shouldBe` False
    it "un pais juega contra otro si pertenecen al mismo grupo" $ do
      juegaContra "Argentina" "Algeria" `shouldBe` True
    it "un pais NO juega contra otro si NO pertenecen al mismo grupo" $ do
      juegaContra "Sudafrica" "Algeria" `shouldBe` False
    it "un pais no juega contra si mismo" $ do
      juegaContra "Sudafrica" "Sudafrica" `shouldBe` False

