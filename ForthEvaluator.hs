
import Prelude
import qualified Data.Map as Map

data NativeFunc = Drop | Plus | Apply | Define deriving (Show)

data ProgramUnit = Word String | Native NativeFunc | ForthInt Int | ForthString String | ForthLambda [ProgramUnit] deriving (Show)

type ProgramStack = [ProgramUnit]
type Dict = (Map.Map String ProgramUnit)

data ProgramState = ProgramState { programStack :: ProgramStack, dataStack :: ProgramStack, dict :: Dict } deriving (Show)

parse :: String -> Either String ProgramState
parse = undefined

evalNativeFunc :: NativeFunc -> ProgramState -> Either String ProgramState
evalNativeFunc Drop (ProgramState {dataStack = []}) = Left "error, cannot drop from empty stack"
evalNativeFunc Drop (p@(ProgramState {dataStack = (_:a)})) = Right $ p { dataStack = a }
evalNativeFunc Plus p@(ProgramState { dataStack = ((ForthInt a):(ForthInt b):c)}) = Right $ p { dataStack = (ForthInt (a + b)):c}
evalNativeFunc Plus a = Left ("error, cannot add " ++ show a)
evalNativeFunc a stack = undefined

eval :: ProgramState -> Either String ProgramStack
eval program = undefined

evalOneStep :: ProgramState -> Either String ProgramState
evalOneStep p@ProgramState{programStack = [] } = Right p
evalOneStep p@ProgramState{programStack = ((Native n):prog)}  = evalNativeFunc n p
evalOneStep p@ProgramState{programStack = ((Word word):prog) } = undefined
evalOneStep p@ProgramState{programStack = (a:prog), dataStack = d }= Right $ p { programStack = prog, dataStack = (a:d) }


