{-
自然数の平方根を小さいものから足していったとき、1000を超えるのは何個目？
-}
sqrtSums :: Int
sqrtSums = length (takeWhile (<1000) (scanl1 (+) (map sqrt [1..]))) + 1 

{-
scanlとscanrの動作それぞれ
Prelude> scanl (+) 0 [3,5,2,1]
[0,3,8,10,11]
Prelude> scanr (+) 0 [3,5,2,1]
[11,8,3,1,0]
-}

{-
結果
*Main> sqrtSums
131
-}