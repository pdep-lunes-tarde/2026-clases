module Spec where
import PdePreludat
import Library
import Test.Hspec

correrTests :: IO ()
correrTests = hspec $ do
  describe "valor absoluto" $ do
    it "el valor absoluto de un numero positivo es el mismo numero" $ do
      valorAbsoluto 1 `shouldBe` 1
    it "el valor absoluto de un numero negativo es su opuesto" $ do
      valorAbsoluto (-5) `shouldBe` 5
    it "el valor absoluto de 0 es 0" $ do
      valorAbsoluto 0 `shouldBe` 0

  fdescribe "esta entre" $ do
    it "si los 3 valores son iguales deberia dar true" $ do
      estaEntre'' 3 3 3 `shouldBe` True
    it "si el valor es menor a la cota inferior es falso" $ do
      estaEntre'' 1 2 3 `shouldBe` False
    it "si el valor es igual a la cota inferior es verdadero" $ do
      estaEntre'' "a" "a" "b" `shouldBe` True
    it "si el valor esta entre las dos cotas es verdadero" $ do
      estaEntre'' 3 2 4 `shouldBe` True
    it "si el valor es igual a la cota superior es verdadero" $ do
      estaEntre'' 4 2 4 `shouldBe` True
    it "si el valor es mayor a la cota superior es falso" $ do
      estaEntre'' 3 1 2 `shouldBe` False
    it "las cotas pueden venir en orden distinto" $ do
      estaEntre'' 3 5 1 `shouldBe` True
    

  describe "preguntar" $ do
    it "si le paso una oracion que ya tiene signos de pregunta, la deja igual" $ do
      preguntar "¿como estas?" `shouldBe` "¿como estas?"

    it "si le paso una oracion que le falta el signo de pregunta que cierra, se lo agrega" $ do
      preguntar "¿como estas" `shouldBe` "¿como estas?"

    it "si le paso una oracion que le falta el signo de pregunta que abre, se lo agrega" $ do
      preguntar "como estas?" `shouldBe` "¿como estas?"
    it "si le paso una oracion sin ningun signo de pregunta, agrega ambos" $ do
      preguntar "hola" `shouldBe` "¿hola?"

