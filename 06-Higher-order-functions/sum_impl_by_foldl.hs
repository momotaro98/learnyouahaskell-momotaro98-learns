sum' :: (Num a) => [a] -> a
sum' xs = foldl (\acc x -> acc + x) 0 xs
{-
左畳み込みfoldlを利用したsum関数の単純実装
-}
