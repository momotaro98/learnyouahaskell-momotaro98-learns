{-
左畳み込みfoldlを利用したsum関数の単純実装
-}
sum' :: (Num a) => [a] -> a
sum' xs = foldl (\acc x -> acc + x) 0 xs
{-
関数がカリー化されていることを踏まえると、上記の実装はもっと簡潔に書くことができます。
(\acc x -> acc + x)と(+)は等価。
foldl (+) 0 はリストを取る関数を返す("[a] -> a"を返す)ので、xsが省略化。
-}
simple_sum' :: (Num a) => [a] -> a
simple_sum' = foldl (+) 0