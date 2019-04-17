data Shape = Circle Float Float Float |
             Rectangle Float Float Float Float

{-
*Main> :t Circle 
Circle :: Float -> Float -> Float -> Shape
*Main> :t Rectangle 
Rectangle :: Float -> Float -> Float -> Float -> Shape

Shapeは型。CircleとRectangleは値コンストラクタと呼ばれる具体的なもの。(Boolが型でTrueが値コンストラクタ)
-}

area :: Shape -> Float
area (Circle _ _ r) = pi * r ^ 2
area (Rectangle x1 y1 x2 y2) = (abs $ x2 - x1) * (abs $ y2 - y1)
{-
*Main> area $ Circle 2 2 2
12.566371
*Main> area $ Rectangle 0 0 3 4
12.0
-}