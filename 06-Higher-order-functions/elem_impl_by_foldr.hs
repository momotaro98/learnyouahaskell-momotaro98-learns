elem' :: (Eq a) => a -> [a] -> Bool
elem' y ys = foldr (\x acc -> if x == y then True else acc) False ys
{-
この場合のアキュムレータはBoolである。
*Main> elem' 3 [1,2,4]
False
*Main> elem' 3 [1,2,3,4]
True
-}