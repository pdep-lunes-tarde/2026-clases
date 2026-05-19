module Spec where
import PdePreludat
import Library
import Test.Hspec
import Control.Exception (evaluate)

correrTests :: IO ()
correrTests = pure ()


deberiaFallar :: a -> Expectation
deberiaFallar a = evaluate a `shouldThrow` anyException
