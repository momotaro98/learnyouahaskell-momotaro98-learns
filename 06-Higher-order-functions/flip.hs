flip' :: (a -> b -> c) -> b -> a -> c
flip' f x y = f y x
{-
flip' fを引数x, yなしで呼び出したら、2つの引数を取る引数の入れ替わったfが返る。←関数のカリー化を利用している。
上記は以下の関数の上位互換の等価。
flip' :: (a -> b -> c) -> (b -> a -> c)
flip' f = g
    where g x y = f y x
-}

{-
Prelude> :l flip.hs
[1 of 1] Compiling Main             ( flip.hs, interpreted )
Ok, one module loaded.
*Main> flip' zip [1,2,3,4,5] "hello"
[('h',1),('e',2),('l',3),('l',4),('o',5)]
-}
