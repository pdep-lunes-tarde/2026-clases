module Spec where
import PdePreludat
import Library
import Test.Hspec

correrTests :: IO ()
correrTests = hspec $ do

  describe "Punto 1: las hamburguesas" $ do

    describe "calorías de una hamburguesa" $ do
      it "una hamburguesa cocinada al vapor solo aporta las calorías base de sus medallones, que es 100 calorías x medallon" $
        calorias cangreburguejaAlVapor `shouldBe` 100
      it "una hamburguesa asada suma 5 calorías por minuto a cada medallón" $
        calorias cangreburgerClasica `shouldBe` 125
      it "una hamburguesa frita en aceite de girasol suma 50 calorías por medallón" $
        calorias hamburguesaFritaGirasol `shouldBe` 150
      it "una hamburguesa frita en aceite de oliva suma 30 calorías por medallón" $
        calorias mcPatricioDeluxe `shouldBe` 260
      it "una hamburguesa frita en aceite de motor reciclado suma 200 calorías por medallón" $
        calorias mcPatricio `shouldBe` 600

    describe "agregar condimentos adicionales a una hamburguesa" $ do
      it "aumenta el precio en la mitad del total de letras de los condimentos agregados" $
        precio (con ["ketchup", "cebolla"] cangreburgerDoble) `shouldBe` 27
      it "agrega los condimentos a los que la hamburguesa ya tenía" $
        condimentos (con ["ketchup", "cebolla"] cangreburgerDoble) `shouldBe` ["ketchup", "cebolla"]

    describe "una hamburguesa está carbonizada" $ do
      it "cuando fue asada durante más de 10 minutos" $
        estaCarbonizada hamburguesaAsadaCarbonizada `shouldBe` True
      it "cuando fue frita en aceite de motor reciclado" $
        estaCarbonizada mcPatricio `shouldBe` True
      it "no lo está si fue asada durante 10 minutos o menos" $
        estaCarbonizada cangreburgerClasica `shouldBe` False
      it "no lo está si fue frita en un aceite distinto al de motor reciclado" $
        estaCarbonizada mcPatricioDeluxe `shouldBe` False
      it "no lo está si fue cocinada al vapor" $
        estaCarbonizada cangreburguejaAlVapor `shouldBe` False

  describe "Punto 2: los clientes" $ do
    describe "a Patricio" $ do
      it "le gusta cualquier hamburguesa" $
        leGusta patricio cangreburgerClasica `shouldBe` True
      it "le da a una hamburguesa un puntaje igual a la suma de sus medallones y sus condimentos" $
        puntajeDe patricio (con ["ketchup", "cebolla"] cangreburgerDoble) `shouldBe` 4

    describe "a Arenita" $ do
      it "le gusta una hamburguesa que tiene alguno de sus condimentos favoritos" $
        leGusta arenita hamburguesaConNueces `shouldBe` True
      it "no le gusta una hamburguesa que no tiene ninguno de sus condimentos favoritos" $
        leGusta arenita cangreburgerClasica `shouldBe` False
      it "puntúa a una hamburguesa según cuántos de sus condimentos favoritos tiene" $
        puntajeDe arenita hamburguesaConDosFavoritosDeArenita `shouldBe` 2
      it "le da puntaje 0 a una hamburguesa que no le gusta" $
        puntajeDe arenita cangreburgerClasica `shouldBe` 0

    describe "a Róbalo Burbuja" $ do
      it "le gusta una hamburguesa de 6 medallones, con sus 3 condimentos y asada al menos 8 minutos" $
        leGusta robaloBurbuja hamburguesaParaRobaloBurbuja `shouldBe` True
      it "no le gusta una hamburguesa que no tenga 6 medallones" $
        leGusta robaloBurbuja cangreburgerClasica `shouldBe` False
      it "no le gusta una hamburguesa que tenga todo lo pedido pero no fue asada al menos 8 minutos" $
        leGusta robaloBurbuja hamburguesaSeisMedallonesAsadaPoco `shouldBe` False
      it "le da a una hamburguesa que le gusta un puntaje que nunca es menor a 1" $
        puntajeDe robaloBurbuja hamburguesaParaRobaloBurbuja `shouldBe` 1
      it "le da puntaje 0 a una hamburguesa que no le gusta" $
        puntajeDe robaloBurbuja cangreburgerClasica `shouldBe` 0

    describe "a una sardina que no está a dieta" $ do
      it "le gusta una hamburguesa que no tiene el condimento al que es alérgica" $
        leGusta (sardina "mostaza" False) cangreburgerClasica `shouldBe` True
      it "no le gusta una hamburguesa que tiene el condimento al que es alérgica" $
        leGusta (sardina "mostaza" False) mcPatricio `shouldBe` False

    describe "a una sardina que está a dieta" $ do
      it "le gusta una hamburguesa sin su alérgeno que aporta menos de 300 calorías" $
        leGusta (sardina "mostaza" True) cangreburgerClasica `shouldBe` True
      it "no le gusta una hamburguesa sin su alérgeno que aporta 300 calorías o más" $
        leGusta (sardina "mostaza" True) hamburguesaTripleFritaGirasol `shouldBe` False

    describe "el puntaje de una sardina" $ do
      it "es 100 por la cantidad de condimentos dividido las calorías de la hamburguesa" $
        puntajeDe (sardina "mostaza" False) hamburguesaAlVaporConNueces `shouldBe` 1
      it "es 0 para una hamburguesa que no le gusta" $
        puntajeDe (sardina "mostaza" False) mcPatricio `shouldBe` 0

    describe "a Plankton" $ do
      it "le gusta una hamburguesa que cuesta 10 o menos" $
        leGusta plankton cangreburgerClasica `shouldBe` True
      it "le gusta una hamburguesa frita aunque cueste más de 10" $
        leGusta plankton mcPatricio `shouldBe` True
      it "no le gusta una hamburguesa que cuesta más de 10 y no es frita" $
        leGusta plankton hamburguesaConNueces `shouldBe` False
      it "le da puntaje 1 a una hamburguesa común que le gusta" $
        puntajeDe plankton cangreburgerClasica `shouldBe` 1
      it "le da puntaje 99999 a una hamburguesa con la fórmula secreta" $
        puntajeDe plankton hamburguesaConFormulaSecretaFrita `shouldBe` 99999

    describe "un cliente compraría alguna hamburguesa del menú" $ do
      it "si le gusta alguna y su precio le alcanza" $
        comprariaAlguna patricio [mcPatricio] `shouldBe` True
      it "no la compra si le gusta pero el precio supera su presupuesto" $
        comprariaAlguna patricio [hamburguesaCara] `shouldBe` False
      it "no la compra si no le gusta ninguna del menú" $
        comprariaAlguna arenita [cangreburgerClasica, mcPatricio] `shouldBe` False

    describe "qué hamburguesa elige un cliente" $ do
      it "elige, entre las que compraría, la de mejor puntaje" $
        cualCompraria patricio [cangreburgerClasica, mcPatricio] `shouldBe` mcPatricio
      it "ante un empate de puntaje se queda con la primera" $
        cualCompraria patricio [cangreburgerDoble, hamburguesaConUnCondimento] `shouldBe` cangreburgerDoble

  describe "Punto 3: el crustáceo cascarudo" $ do
    describe "atender a un cliente" $ do
      it "aumenta el dinero en el precio de la hamburguesa elegida cuando compra alguna" $
        dinero (atender patricio crustaceoCascarudo) `shouldBe` 20
      it "deja al crustáceo igual cuando el cliente no compra ninguna" $
        dinero (atender arenita crustaceoCascarudo) `shouldBe` 5

    describe "el menú del día fue un éxito" $ do
      it "cuando para cada hamburguesa del menú hay un cliente que la compraría" $
        elMenuFueUnExito [patricio] crustaceoConMenuFacil `shouldBe` True
      it "no lo fue si alguna hamburguesa del menú no la compraría ningún cliente" $
        elMenuFueUnExito [patricio] crustaceoConHamburguesaCara `shouldBe` False

    describe "pasar un día de trabajo" $ do
      it "atiende a los clientes y descuenta los sueldos más el extra si el menú fue un éxito" $
        dinero (pasarUnDiaDeTrabajo [patricio] crustaceoConMenuFacil) `shouldBe` 96
      it "atiende a los clientes y descuenta solo los sueldos si el menú no fue un éxito" $
        dinero (pasarUnDiaDeTrabajo [patricio] crustaceoConHamburguesaCara) `shouldBe` 98


-- Hamburguesas de prueba

hamburguesaFritaGirasol :: Hamburguesa
hamburguesaFritaGirasol = conCoccion (Frita Girasol) cangreburgerClasica

hamburguesaAsadaCarbonizada :: Hamburguesa
hamburguesaAsadaCarbonizada = conCoccion (Asada 12) cangreburgerClasica

hamburguesaConNueces :: Hamburguesa
hamburguesaConNueces = con ["nueces"] cangreburgerClasica

hamburguesaConDosFavoritosDeArenita :: Hamburguesa
hamburguesaConDosFavoritosDeArenita = con ["nueces", "almendras", "mostaza"] cangreburgerClasica

hamburguesaParaRobaloBurbuja :: Hamburguesa
hamburguesaParaRobaloBurbuja = Hamburguesa {
        coccion = Asada 8,
        condimentos = [
          "guijarros extra con vibración exprimida",
          "eje con grasa ligera",
          "pepinillos"
        ],
        cantidadMedallones = 6,
        precio = 10
      }

hamburguesaAlVaporConNueces :: Hamburguesa
hamburguesaAlVaporConNueces = con ["nueces"] cangreburguejaAlVapor

hamburguesaConFormulaSecretaFrita :: Hamburguesa
hamburguesaConFormulaSecretaFrita =
  conCoccion (Frita Girasol) (con ["La fórmula secreta de las cangreburgers"] cangreburgerClasica)

hamburguesaCara :: Hamburguesa
hamburguesaCara = con ["mayonesa"] (cangreburgerMultiple 5)

hamburguesaConUnCondimento :: Hamburguesa
hamburguesaConUnCondimento = con ["ketchup"] cangreburgerClasica

hamburguesaTripleFritaGirasol :: Hamburguesa
hamburguesaTripleFritaGirasol = conCoccion (Frita Girasol) (cangreburgerMultiple 3)

hamburguesaSeisMedallonesAsadaPoco :: Hamburguesa
hamburguesaSeisMedallonesAsadaPoco =
  con [
    "guijarros extra con vibración exprimida",
    "eje con grasa ligera",
    "pepinillos"
  ] (cangreburgerMultiple 6)

-- Crustáceos de prueba

crustaceoConMenuFacil :: CrustaceoCascarudo
crustaceoConMenuFacil = crustaceoCascarudo {
  menu = [cangreburgerClasica, cangreburguejaAlVapor],
  dinero = 100
}

crustaceoConHamburguesaCara :: CrustaceoCascarudo
crustaceoConHamburguesaCara = crustaceoCascarudo {
  menu = [cangreburgerClasica, hamburguesaCara],
  dinero = 100
}
