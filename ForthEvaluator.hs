
module ForthEvaluator where
import Prelude
import qualified Data.Map as Map

data NativeFunc = Drop | Plus | Apply | Eval | Define deriving (Show, Eq)

data ProgramUnit = Word String | Symbol String | Native NativeFunc | ForthInt Int | ForthString String | ForthLambda [ProgramUnit] deriving (Show, Eq)

type ProgramStack = [ProgramUnit]
type Dict = (Map.Map String ProgramUnit)

data ProgramState = ProgramState { programStack :: ProgramStack, dataStack :: ProgramStack, dict :: Dict } deriving (Show, Eq)

parse :: String -> Either String ProgramState
parse = undefined

evalNativeFunc :: NativeFunc -> ProgramState -> Either String ProgramState
evalNativeFunc Drop (ProgramState {dataStack = []}) = Left "error, cannot drop from empty stack"
evalNativeFunc Drop (p@(ProgramState {dataStack = (_:a)})) = Right $ p { dataStack = a }
evalNativeFunc Plus p@(ProgramState { dataStack = ((ForthInt a):(ForthInt b):c)}) = Right $ p { dataStack = (ForthInt (a + b)):c }
evalNativeFunc Plus a = Left ("error, cannot add " ++ show a)
evalNativeFunc Define p@ProgramState {
    dataStack = ((Symbol symbolName):definition:rest),
    dict = oldDict
    } = let newDict = Map.insert symbolName definition oldDict in Right $ p {dataStack = rest, dict = newDict}
evalNativeFunc Define p = Left "cannot define"
evalNativeFunc Eval (p@ProgramState { dataStack = (ForthLambda lambda):prog }) = undefined
evalNativeFunc a stack = undefined

eval :: ProgramState -> Either String ProgramState
eval program = if null . programStack $ program
    then Right program
    else evalOneStep program >>= eval

getDefinition :: Dict -> String -> Either String ProgramUnit
getDefinition dict key = case (Map.lookup key dict) of
                            Just expr -> Right expr
                            Nothing -> Left $ "Word " ++ key ++ " not defined"

evalOneStep :: ProgramState -> Either String ProgramState
evalOneStep p@ProgramState { programStack = [] } = Right p
evalOneStep p@ProgramState { programStack = ((Native n):prog)}  = evalNativeFunc n (p {programStack = prog})
evalOneStep p@ProgramState { programStack = ((Word word):prog) , dict = d } = getDefinition d word >>= \programUnit -> Right $ p { programStack = (programUnit:prog) }
evalOneStep p@ProgramState { programStack = (a:prog), dataStack = d }= Right $ p { programStack = prog, dataStack = (a:d) }


exampleProgramState = ProgramState [(ForthInt 5), (Symbol "y"), (Native Define), (Word "y")] [] (Map.fromList [("x", ForthInt 6 )])

