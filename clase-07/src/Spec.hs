module Spec where
import PdePreludat
import Library
import Test.Hspec

correrTests :: IO ()
correrTests = hspec $ do
  describe "test de prueba" $ do
    it "test" $ do
      2 + 2 `shouldBe` 4
