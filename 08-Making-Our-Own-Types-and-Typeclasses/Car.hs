-- レコード構文
data Car = Car { company :: String
               , model :: String
               , year :: Int
               } deriving (Show)

{-
*Main> Car {company="Toyota", model="Carora", year=1999}
Car {company = "Toyota", model = "Carora", year = 1999}
*Main> let ford_car = Car {company="Ford", model="Mustang", year=1967}
*Main> model ford_car
"Mustang"
-}