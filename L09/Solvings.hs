module Solvings where 

cycl :: [a] -> [a]
cycl list = list ++ (cycl list)

{- Got my inspiration from oneList function from Circular module-}
series :: [[Int]]
series = [1]:(map (\xs -> ((head xs) + 1):xs) series)

iter :: (a -> a) -> a -> [a]
iter f a = a : iterHelper f (f a) where
     iterHelper func x = x : iterHelper func (func x)