-- ---
-- title: Homework #2, Due Friday 2/12/16
-- ---

{-# LANGUAGE TypeSynonymInstances #-}
{-# LANGUAGE FlexibleContexts #-}

module Hw2 where
import Debug.Trace
import Control.Applicative hiding (empty, (<|>))
import qualified Data.Map
import Control.Monad.State hiding (when)
import Text.Parsec hiding (State, between)
import Text.Parsec.Combinator hiding (between)
import Text.Parsec.Char
import Text.Parsec.String
import Data.Maybe
-- import Data.Char

-- Problem 0: All About You
-- ========================

-- Tell us your name, email and student ID, by replacing the respective
-- strings below

myName  = "Xinyu Zhang"
myEmail = "xiz368@eng.ucsd.edu"
mySID   = "A53095838"


-- Problem 1: All About `foldl`
-- ============================

-- Define the following functions by filling in the "error" portion:

-- 1. Describe `foldl` and give an implementation:

myFoldl :: (a -> b -> a) -> a -> [b] -> a
myFoldl f b [] = b
myFoldl f b (x:xs) =  (myFoldl f b xs)  `f` x
-- TEST: myFoldl (\x y -> x+y) 1  [1,2,3,4]

-- 2. Using the standard `foldl` (not `myFoldl`), define the list reverse function:

myReverse :: [a] -> [a]
myReverse  = foldl (flip (:)) []
-- TEST: myReverse [1,2,3,4]


-- 3. Define `foldr` in terms of `foldl`:

myFoldr :: (a -> b -> b) -> b -> [a] -> b
myFoldr f b xs = foldl (flip f) b (reverse xs)
-- TEST: myFoldr (\x y -> x++y) "2"  ["1","2","3","4"]


-- 4. Define `foldl` in terms of the standard `foldr` (not `myFoldr`):



myFoldl2 :: (a -> b -> a) -> a -> [b] -> a
myFoldl2 f b xs = foldr (flip f) b (reverse xs)
-- TEST: myFoldl2 (\x y -> x++y) "2"  ["1","2","3","4"]

-- 5. Try applying `foldl` to a gigantic list. Why is it so slow?
--    Try using `foldl'` (from [Data.List](http://www.haskell.org/ghc/docs/latest/html/libraries/base/Data-List.html#3))
--    instead; can you explain why it's faster?

-- Part 2: Binary Search Trees
-- ===========================

-- Recall the following type of binary search trees:

data BST k v = Emp
             | Bind k v (BST k v) (BST k v)
             deriving (Show)

-- Define a `delete` function for BSTs of this type:

delete :: (Ord k) => k -> BST k v -> BST k v
delete _ Emp = Emp
delete k (Bind k' _ Emp r) | k == k' = r
delete k (Bind k' _ l Emp) | k == k' = l
delete k (Bind k' v' l r)
   | k <  k'   = Bind k' v' (delete k l) r
   | k >  k'   = Bind k' v' l (delete k r)
   | otherwise = Bind key value l' r
                 where (key,value) = maxKey l
                       l'          = delete key l

maxKey ::  (BST k v) -> (k,v)
maxKey Emp = error "Never Reach here, since the `delete _ Emp = Emp`"
maxKey (Bind k v _ Emp) = (k,v)
maxKey (Bind _ _ _ r) = maxKey r

-- TEST:
-- x = Bind "chimichanga" 5.25
--   (Bind "burrito" 4.5 Emp Emp)
--   (Bind "frijoles" 2.75 Emp Emp)
-- delete "burrito"  x


-- Part 3: An Interpreter for WHILE
-- ================================

-- Next, you will use monads to build an evaluator for
-- a simple *WHILE* language. In this language, we will
-- represent different program variables as

type Variable = String

-- Programs in the language are simply values of the type

data Statement =
    Assign Variable Expression          -- x = e
  | If Expression Statement Statement   -- if (e) {s1} else {s2}
  | While Expression Statement          -- while (e) {s}
  | Sequence Statement Statement        -- s1; s2
  | Skip                                -- no-op
  deriving (Show)

-- where expressions are variables, constants or
-- binary operators applied to sub-expressions

data Expression =
    Var Variable                        -- x
  | Val Value                           -- v
  | Op  Bop Expression Expression
  deriving (Show)

-- and binary operators are simply two-ary functions

data Bop =
    Plus     -- (+)  :: Int  -> Int  -> Int
  | Minus    -- (-)  :: Int  -> Int  -> Int
  | Times    -- (*)  :: Int  -> Int  -> Int
  | Divide   -- (/)  :: Int  -> Int  -> Int
  | Gt       -- (>)  :: Int -> Int -> Bool
  | Ge       -- (>=) :: Int -> Int -> Bool
  | Lt       -- (<)  :: Int -> Int -> Bool
  | Le       -- (<=) :: Int -> Int -> Bool
  deriving (Show)

data Value =
    IntVal Int
  | BoolVal Bool
  deriving (Show,Eq)

-- We will represent the *store* i.e. the machine's memory, as an associative
-- map from `Variable` to `Value`

type Store = Data.Map.Map Variable Value

-- **Note:** we don't have exceptions (yet), so if a variable
-- is not found (eg because it is not initialized) simply return
-- the value `0`. In future assignments, we will add this as a
-- case where exceptions are thrown (the other case being type errors.)

-- We will use the standard library's `State`
-- [monad](http://hackage.haskell.org/packages/archive/mtl/latest/doc/html/Control-Monad-State-Lazy.html#g:2)
-- to represent the world-transformer.
-- Intuitively, `State s a` is equivalent to the world-transformer
-- `s -> (a, s)`. See the above documentation for more details.
-- You can ignore the bits about `StateT` for now.

-- Expression Evaluator
-- --------------------

-- First, write a function

evalE :: Expression -> State Store Value
-- that takes as input an expression and returns a world-transformer that
-- returns a value. Yes, right now, the transformer doesnt really transform
-- the world, but we will use the monad nevertheless as later, the world may
-- change, when we add exceptions and such.

-- **Hint:** The value `get` is of type `State Store Store`. Thus, to extract
-- the value of the "current store" in a variable `s` use `s <- get`.

evalOp :: Bop -> Value -> Value -> Value
evalOp Plus (IntVal i) (IntVal j) = IntVal (i+j)
evalOp Minus  (IntVal i) (IntVal j) = IntVal (i-j)
evalOp Times  (IntVal i) (IntVal j) = IntVal (i*j)
evalOp Divide (IntVal i) (IntVal j) = IntVal (i `div` j)
evalOp Gt (IntVal i) (IntVal j) = BoolVal (i>j)
evalOp Ge  (IntVal i) (IntVal j) = BoolVal (i>=j)
evalOp Lt  (IntVal i) (IntVal j) = BoolVal (i<j)
evalOp Le   (IntVal i) (IntVal j) = BoolVal (i<=j)


-- >

evalVariable :: Maybe Value -> Value
evalVariable  (Just x) = x
evalVariable  Nothing  = IntVal 0  -- Dealing with exception here


evalE (Var x)      = do
                        st <- get
                        return (evalVariable (Data.Map.lookup x st))


evalE (Val v)      = do return v


evalE (Op o e1 e2) = do
                      v1 <- evalE e1
                      v2 <- evalE e2
                      evalE (Val (evalOp o v1 v2))



-- Statement Evaluator
-- -------------------

-- Next, write a function

evalS :: Statement -> State Store ()

-- that takes as input a statement and returns a world-transformer that
-- returns a unit. Here, the world-transformer should in fact update the input
-- store appropriately with the assignments executed in the course of
-- evaluating the `Statement`.

-- **Hint:** The value `put` is of type `Store -> State Store ()`.
-- Thus, to "update" the value of the store with the new store `s'`
-- do `put s'`.

evalS (Assign x e )    =  do
                            st <- get
                            v <- evalE e
                            put (Data.Map.insert x v st)
                            return ()




evalS w@(While e s)    = do
                           c <- evalE e
                           if c == BoolVal True then
                             do
                               evalS s  -- how to make sure they work in the same store
                               evalS w
                           else
                             return ()



evalS Skip             = return ()


evalS (Sequence s1 s2) = do
                            evalS s1
                            evalS s2

evalS (If e s1 s2)     =  do
                            c <- evalE e
                            if c == BoolVal True then
                                evalS s1
                            else
                                evalS s2

-- In the `If` case, if `e` evaluates to a non-boolean value, just skip both
-- the branches. (We will convert it into a type error in the next homework.)
-- Finally, write a function
-- State Store Value


execS :: Statement -> Store -> Store
execS statement sto  = execState (evalS statement)  sto



-- such that `execS stmt store` returns the new `Store` that results
-- from evaluating the command `stmt` from the world `store`.
-- **Hint:** You may want to use the library function

-- ~~~~~{.haskell}
-- execState :: State s a -> s -> s
-- ~~~~~

-- When you are done with the above, the following function will
-- "run" a statement starting with the `empty` store (where no
-- variable is initialized). Running the program should print
-- the value of all variables at the end of execution.

run :: Statement -> IO ()
run stmt = do putStrLn "Output Store:"
              print ( execS stmt Data.Map.empty )

-- Here are a few "tests" that you can use to check your implementation.

w_test = (Sequence (Assign "X" (Op Plus (Op Minus (Op Plus (Val (IntVal 1)) (Val (IntVal 2))) (Val (IntVal 3))) (Op Plus (Val (IntVal 1)) (Val (IntVal 3))))) (Sequence (Assign "Y" (Val (IntVal 0))) (While (Op Gt (Var "X") (Val (IntVal 0))) (Sequence (Assign "Y" (Op Plus (Var "Y") (Var "X"))) (Assign "X" (Op Minus (Var "X") (Val (IntVal 1))))))))

w_fact = (Sequence (Assign "N" (Val (IntVal 2))) (Sequence (Assign "F" (Val (IntVal 1))) (While (Op Gt (Var "N") (Val (IntVal 0))) (Sequence (Assign "X" (Var "N")) (Sequence (Assign "Z" (Var "F")) (Sequence (While (Op Gt (Var "X") (Val (IntVal 1))) (Sequence (Assign "F" (Op Plus (Var "Z") (Var "F"))) (Assign "X" (Op Minus (Var "X") (Val (IntVal 1)))))) (Assign "N" (Op Minus (Var "N") (Val (IntVal 1))))))))))

-- As you can see, it is rather tedious to write the above tests! They
-- correspond to the code in the files `test.imp` and `fact.imp`. When you are
-- done, you should get

-- ~~~~~{.haskell}
-- ghci> run w_test
-- Output Store:
-- fromList [("X",IntVal 0),("Y",IntVal 10)]

-- ghci> run w_fact
-- Output Store:
-- fromList [("F",IntVal 2),("N",IntVal 0),("X",IntVal 1),("Z",IntVal 2)]
-- ~~~~~

-- Problem 4: A Parser for WHILE
-- =============================

-- It is rather tedious to have to specify individual programs as Haskell
-- values. For this problem, you will use parser combinators to build a parser
-- for the WHILE language from the previous problem.

-- Parsing Constants
-- -----------------

myparse:: Parser a -> String -> Either ParseError a
myparse p = parse p "Source"


newlines :: Parser ()
newlines = skipMany newline


colons :: Parser ()
colons = skipMany (char ';')

-- First, we will write parsers for the `Value` type

valueP :: Parser Value
valueP = intP <|> boolP

-- To do so, fill in the implementations of




intP :: Parser Value
intP =  do
          -- kw <- string "IntVal"
          spaces
          digits <- many1 digit
          return  (IntVal (read digits :: Int))


-- Next, define a parser that will accept a
-- particular string `s` as a given value `x`

constP :: String -> a -> Parser a
constP s x = do
                kw <- string s
                return x


-- and use the above to define a parser for boolean values
-- where `"true"` and `"false"` should be parsed appropriately.

boolP :: Parser Value
boolP = do
          -- kw <- string "BoolVal"
          spaces
          val <- (constP "\"true\"" True) <|>  (constP "\"false\"" False)
          return (BoolVal val)





        --   Plus     -- (+)  :: Int  -> Int  -> Int
        -- | Minus    -- (-)  :: Int  -> Int  -> Int
        -- | Times    -- (*)  :: Int  -> Int  -> Int
        -- | Divide   -- (/)  :: Int  -> Int  -> Int
        -- | Gt       -- (>)  :: Int -> Int -> Bool
        -- | Ge       -- (>=) :: Int -> Int -> Bool
        -- | Lt       -- (<)  :: Int -> Int -> Bool
        -- | Le
-- Continue to use the above to parse the binary operators
opP :: Parser Bop
opP = constP "+" Plus
      <|> constP "-" Minus
      <|> constP "*" Times
      <|> constP "/" Divide
      <|> constP ">" Gt
      <|> constP ">=" Ge
      <|> constP "<" Lt
      <|> constP "<=" Le




-- Parsing Expressions
-- -------------------

-- Next, the following is a parser for variables, where each
-- variable is one-or-more uppercase letters.

varP :: Parser Variable
varP = many1 upper

-- Use the above to write a parser for `Expression` values
-- data Expression =
--     Var Variable                        -- x
--   | Val Value                           -- v
--   | Op  Bop Expression Expression
--   deriving (Show)


-- data Expression =
--     Var Variable                        -- x
--   | Val Value                           -- v
--   | Op  Bop Expression Expression
--   deriving (Show)


exprVar = do
            spaces
            var <- varP
            colons
            return (Var var)

exprVal = do
            spaces
            val <- valueP
            colons
            return (Val val)




parenP p = do
              char '('
              x <- p
              char ')'
              return x


exprOp =  do
             spaces
             ex1 <-  (parenP exprP) <|> exprVal <|> exprVar
             spaces
             op <- opP
             spaces
             ex2 <-  (parenP exprP) <|> exprP
             return (Op op ex1 ex2)




exprP :: Parser Expression
exprP =  try exprOp <|> exprVar <|> exprVal

-- Parsing Statements
-- ------------------



-- Next, use the expression parsers to build a statement parser
-- data Statement =
--     Assign Variable Expression          -- x = e
--   | If Expression Statement Statement   -- if (e) {s1} else {s2}
--   | While Expression Statement          -- while (e) {s}
--   | Sequence Statement Statement        -- s1; s2
--   | Skip                                -- no-op
--   deriving (Show)

stAssign = do
              spaces
              var <- varP
              spaces
              kw <- string ":="
              spaces
              ex <- exprP
              return (Assign  var ex)


stIf = do
        spaces
        kwif <- string "if"
        spaces
        cond <- exprP
        spaces
        kwthen <- string "then"
        newlines
        stThen <- statementP
        newlines
        kwElse <- string "else"
        newlines
        stElse <- statementP
        newlines
        kwEnd <- string "endif"
        return (If cond stThen  stElse)

stWhile = do
            spaces
            kwWhile <- string "while"
            spaces
            cond <- exprP
            spaces
            kwdo <- string "do"
            newlines
            st <- statementP
            newlines
            spaces
            kwEnd <- string "endwhile"
            return (While cond st)


-- skipP = newlines <|> spaces



stSkip = do
            spaces
            kw <- string "skip"
            return Skip

-- 1. statementP 第一个不能=sequence
-- 2. statementP 考虑 eof 问题
maybeP:: Parser a -> Parser (Maybe a)
maybeP p = do
          x <- p
          return (Just x)


statementP' :: Parser Statement
statementP' = try stAssign
          <|> try stIf
          <|> try stWhile
          <|> try stSkip




statementP'' :: Parser (Maybe Statement)
statementP'' = maybeP statementP'  <|> return Nothing


stSequence = do
               mbst1 <- statementP''
               if isNothing mbst1 then
                    return Skip
               else
                 do
                    colons
                    newlines
                    st2 <- statementP
                    return (Sequence (fromMaybe Skip mbst1) st2)


statementP :: Parser Statement
statementP = stSequence
            <|> statementP'
            -- <|> return Skip

-- When you are done, we can put the parser and evaluator together
-- in the end-to-end interpreter function


parseFile s =  do
                  p <- parseFromFile statementP s
                  print p


runFile s = do p <- parseFromFile statementP s
               case p of
                 Left err   -> print err
                 Right stmt -> run stmt

-- When you are done you should see the following at the ghci prompt

-- ~~~~~{.haskell}
-- ghci> runFile "test.imp"
-- Output Store:
-- fromList [("X",IntVal 0),("Y",IntVal 10)]

-- ghci> runFile "fact.imp"
-- Output Store:
-- fromList [("F",IntVal 2),("N",IntVal 0),("X",IntVal 1),("Z",IntVal 2)]
-- ~~~~~
