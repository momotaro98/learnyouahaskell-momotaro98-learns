zipWith' :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWith' _ [] _ = []
zipWith' _ _ [] = []
zipWith' f (x:xs) (y:ys) = f x y : zipWith' f xs ys

{-
Main> zipWith' (+) [4,2,5,6] [2,6,2,3]
[6,8,7,9]
*Main> zipWith' max [4,2,5,6] [2,6,2,3]
[4,6,5,6]
*Main> zipWith' (++) ["Golden","Silver","Bronz"] ["sun", "moon", "Rich"]
["Goldensun","Silvermoon","BronzRich"]
*Main> zipWith' (*) (replicate 5 2) [1..]
[2,4,6,8,10]
*Main> zipWith' (zipWith' (*)) [[1,2,3],[3,5,6],[2,3,4]] [[3,2,2],[3,4,5],[5,4,3]]
[[3,4,6],[9,20,30],[10,12,12]]
-}
