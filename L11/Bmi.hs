module Bmi where

main :: IO ()
main =
    do
        putStrLn "Introduce your weight: "
        weightString <- getLine
        putStrLn "Introduce your height: "
        heigthString <- getLine

        let 
            wightDouble = read weightString :: Double 
            heightDouble = read heigthString :: Double
            bmiDouble = wightDouble / (heightDouble * heightDouble)
            bmiString = show bmiDouble
        putStrLn ("Your bmi is: " ++ bmiString)