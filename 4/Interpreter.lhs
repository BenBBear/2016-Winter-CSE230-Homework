Part 3: An Interpreter for WHILE
================================

\begin{code}
{-@ LIQUID "--no-termination" @-}
{-# LANGUAGE FlexibleContexts #-}

module Interpreter (interpret) where
import Control.Monad.State
import           Prelude hiding (lookup)
import qualified Data.Set as S

\end{code}

**HINT:** To do this problem, first go through [this case study](http://ucsd-progsys.github.io/lh-workshop/05-case-study-eval.html)
also included in your tarball as `case-study-eval.lhs`.

Next, you will revisit your interpreter for the *WHILE* 
language to ensure that execution never fails due to a 
*use-before-definition* error.

Recall that FIXME.

Programs in the language are simply values of the type

\begin{code}
data Statement =
    Assign Variable Expression            -- x = e
  | IfZ    Expression Statement Statement -- if (e) {s1} else {s2}
  | WhileZ Expression Statement           -- while (e) {s}
  | Sequence Statement Statement          -- s1; s2
  | Skip                                  -- no-op
\end{code}

to simplify matters, we assume the branch statement `IfZ e s1 s2`
evaluates `e` and then executes `s1` if the value of `e` equals `0`
and otherwise evaluates `s2`.

Thus, the expressions are variables, constants or binary operators applied to sub-expressions

\begin{code}
data Expression =
    Var Variable                        -- x
  | Val Value                           -- v
  | Op  Bop Expression Expression
\end{code}

and binary operators are simply two-ary functions

\begin{code}
data Bop =
    Plus     -- (+)  :: Int  -> Int  -> Int
  | Minus    -- (-)  :: Int  -> Int  -> Int
\end{code}

and variables and values are just:

\begin{code}
type Variable = String
type Value    = Int
\end{code}

Store
-----

We will represent the *store* i.e. the machine's memory, as a list of 
`Variable` - `Value` pairs:

\begin{code}
type Store = [(Variable, Value)]

update :: Store -> Variable -> Value -> Store 
update st x v = (x, v) : st

lookup :: Variable -> Store -> Value 
lookup x ((y, v) : st)
  | x == y         = v 
  | otherwise      = lookup x st
lookup x []        = impossible "variable not found"
\end{code}

Evaluation
----------

We can now write a function that evaluates `Statement` in a `Store` to yield a
new *updated* `Store`:

\begin{code}
evalS :: Store -> Statement -> Store

evalS st Skip             = st

evalS st (Assign x e )    = update st x v
                            where
                              v = evalE st e

evalS st (IfZ e s1 s2)    = if v == 0
                              then evalS st s1
                              else evalS st s2
                            where
                              v = evalE st e
evalS st w@(WhileZ e s)   = if v == 0
                              then evalS st (Sequence s w)
                              else st
                            where
                              v = evalE st e

evalS st (Sequence s1 s2) = evalS (evalS st s1) s2
\end{code}

The above uses a helper that evaluates an `Expression` in a `Store` to get a
`Value`:

\begin{code}
evalE :: Store -> Expression -> Value
evalE st (Var x)      = lookup x st
evalE _  (Val v)      = v
evalE st (Op o e1 e2) = evalOp o (evalE st e1) (evalE st e2)

evalOp :: Bop -> Value -> Value -> Value
evalOp Plus  i j = i + j
evalOp Minus i j = i - j
\end{code}

GOAL: A Safe Evaluator
----------------------

Our goal is to write an evaluator that *never* fails due to an undefined
variable. This means, we must ensure that the evaluator is never called
with *malformed* programs in which some variable is *used-before-being-defined*.

In particular, this corresponds to establishing that the call to impossible
*never* happens at run time, by verifying that the below typechecks:

\begin{code}
{-@ impossible :: {v:String | false} -> a @-}
impossible msg = error msg
\end{code}

Obviously it is possible to throw an exception if you run `evalS` with a
*bad* statement. Your task is to complete the implementation of `isSafe`
and add suitable refinement type specifications, such that you can prove
that the following `interpret` function is safe:

\begin{code}



interpret :: Statement -> Maybe Store
interpret s 
  | isSafe s  = Just (evalS [] s)  -- `s` does not use any vars before definition 
  | otherwise = Nothing            -- `s` may use some var before definition


initial:: State (S.Set Variable) (S.Set Variable)
initial = return S.empty
{-@ inline isSafe @-}
isSafe :: Statement -> Bool
isSafe s = (S.size $ readS' s) == 0  
\end{code}

\begin{code}



                                  
{-@ measure readS' :: Statement -> S.Set Variable @-}

readS' :: Statement -> S.Set Variable
readS' s = a  where (a, _) = runState (readS s) S.empty

-- one is all variables defined, one is all variables that is not define
readS :: Statement -> (State (S.Set Variable) (S.Set Variable))
readS (Assign x e)  = do
                         st <- get
                         us <- readE e 
                         put (S.insert x st)                          
                         return us
                                                         
readS (IfZ e s1 s2)    = do
                           sue <- readE e
                           sus1 <- readS s1
                           sus2 <- readS s2
                           return $ sue `S.union` sus1 `S.union` sus2
  

readS (WhileZ e s)     = do
                           sue <- readE e
                           sus <- readS s
                           return $ sue `S.union` sus
 
readS (Sequence s1 s2) = do
                           sus1 <- readS s1
                           sus2 <- readS s2
                           return $ sus1 `S.union` sus2
                           
readS Skip             = return S.empty   

{-@ measure readE @-}
readE :: Expression -> (State (S.Set Variable) (S.Set Variable))
readE (Var x)          = do
                           st <- get
                           if (S.member x st)
                             then
                               return S.empty
                             else
                               return (S.insert x S.empty)

                               
readE (Val v)          = return S.empty

readE (Op o e1 e2)     = do
                           sue1 <- readE e1
                           sue2 <- readE e2
                           return $ sue1 `S.union` sue2                           
\end{code}


When you are done, `liquid Interpreter.lhs` should return `SAFE` and also when
you run it in GHCi you should get:

\begin{spec}
ghci> let okStmt = ...
ghci> interpret okStmt 
Just ...

ghci> let badStmt = ... 
ghci> interpret badStmt 
Nothing ...
\end{spec}
