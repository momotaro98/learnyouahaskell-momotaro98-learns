data Vector a = Vector a a a deriving (Show)

vplus :: (Num a) => Vector a -> Vector a -> Vector a
(Vector i j k) `vplus` (Vector l m n) = Vector (i+l) (j+m) (k+n)

dotProd :: (Num a) => Vector a -> Vector a -> a
(Vector i j k) `dotProd` (Vector l m n) = i*l + j*m + k*n

vmult:: (Num a) => Vector a -> Vector a -> Vector a
(Vector i j k) `vmult` (Vector l m n) = Vector (i*l) (j*m) (k*n)

{-
*Main> :l Vector.hs
[1 of 1] Compiling Main             ( Vector.hs, interpreted )
Ok, one module loaded.
*Main> Vector 3 2 5 `vplus` Vector 8 6 2
Vector 11 8 7
*Main> (Vector 3 2 5 `vplus` Vector 8 6 2) `vmult` Vector 1 2 3
Vector 11 16 21
-}