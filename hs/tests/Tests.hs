import Test.Tasty
import Test.Tasty.QuickCheck as QC

import Control.Applicative

import Text.Parsec

import Language.Typify

-- Main
main :: IO ()
main = defaultMain tests

tests :: TestTree
tests = qcProps

-- Test

squash :: Either a b -> Maybe b
squash (Left _) = Nothing
squash (Right r) = Just r

parseShowProp :: Type -> Property
parseShowProp t = squash (parse (pretty <$> totalTypeParser) "" t') === Just t'
  where t' = pretty t

qcProps :: TestTree
qcProps = QC.testProperty "parse . show . pretty = pretty" parseShowProp
