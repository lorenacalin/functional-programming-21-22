
module YesNo where

class YesNo a where
  yesno :: a -> Bool

instance YesNo [a] where
  yesno [] = False
  yesno _ = True

instance YesNo Int where
  yesno 0 = False
  yesno _ = True

instance YesNo Bool where
  yesno b = b


-- exercise 10.9.2
instance YesNo (Maybe x) where
  yesno (Just x) = True
  yesno Nothing = False



class YesNoLen a where
  yesnoLen :: a -> Int

instance (YesNo a) => YesNoLen [a] where
  yesnoLen l = length $ filter yesno l

