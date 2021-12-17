module TreeFunctor where

data Tree a = Nil | Node (Tree a) a (Tree a) deriving (Show)

instance Functor Tree where
    fmap _ Nil = Nil
    fmap f (Node left element right) = Node (fmap f left) (f element) (fmap f right)