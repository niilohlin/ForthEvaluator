
module Tests where

import Test.HUnit
import Prelude
import ForthEvaluator
import qualified Data.Map as Map

test1 = TestCase (assertEqual "'5 4 +' is 9" [ForthInt 9] (getData . eval $ pState))
    where
        pState = ProgramState [(ForthInt 5), (ForthInt 4), (Native Plus)] [] (Map.fromList [])
        getData (Right (ProgramState { dataStack = d })) = d
        getData (Left _) = []

tests = TestList [TestLabel "test1" test1]
