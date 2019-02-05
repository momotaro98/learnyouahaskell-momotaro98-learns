maximum' :: (Ord a) => [a] -> a            -- ①
maximum' [] = error "空リストの最大値！？" -- ②
maximum' [x] = x                           -- ③
maximum' (x:xs) = max x (maximum' xs)      -- ④
