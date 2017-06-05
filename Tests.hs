
module Tests where

import Test.HUnit
import Prelude
import ForthEvaluator
import qualified Data.Map as Map


evaluatesTo :: ProgramStack -> ProgramStack -> Bool
evaluatesTo input output = getDataStack (eval pState) == Just output
    where
        pState = ProgramState input [] (Map.fromList [])
        getDataStack (Right (ProgramState { dataStack = d })) = Just d
        getDataStack (Left _) = Nothing


test1 = TestCase . assert $ [ForthInt 5, ForthInt 4, Native Plus]  `evaluatesTo` [ForthInt 9]

test2 = TestCase . assert $ [ForthInt 5, Symbol "x"]  `evaluatesTo` [Symbol "x", ForthInt 5]

test3 = TestCase . assert $ [ForthInt 5, Symbol "x", Native Define, Word "x"]  `evaluatesTo` [ForthInt 5]

tests = TestList [TestLabel "test1" test1
                 ,TestLabel "test2" test2
                 ,TestLabel "test3" test3
                 ]
