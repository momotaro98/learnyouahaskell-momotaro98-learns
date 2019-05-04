import qualified Data.Map as Map

data LockerState = Taken | Free deriving (Show, Eq)

type Code = String

type LockerMap = Map.Map Int (LockerState, Code)
-- Mapは2つの引数を取る型コンストラクタ
-- 上記では2つとも受け取っているのでLockerMapは値コンストラクタ(具体値)

lockerLookup :: Int -> LockerMap -> Either String Code
lockerLookup lockerNumber map = case Map.lookup lockerNumber map of
    Nothing -> Left $ "Locker " ++ show lockerNumber ++ " doesn't exist."
    Just (state, code) -> if state /= Taken
                            then Right code
                            else Left $ "Locker " ++ show lockerNumber ++ "is already taken."
{-
Eitherは`data Either a b = Left a | Right b deriving (Eq, Ord, Read, Show`と定義される型コンストラクタ。
lockerLookup関数は`Either String Code`という"型"を最後に返す。
`Map.lookup lockerNumber map`は一般的な言語でのmap[lockerNumber]と同義。
-}

-- 次のようなMapがあったとしましょう。
lockers :: LockerMap
lockers = Map.fromList
    [(100, (Taken, "ZD39I"))
    ,(101, (Free, "JAH3I"))
    ,(103, (Free, "IQSA9"))
    ,(105, (Free, "JAH3I"))
    ,(109, (Taken, "893JJ"))
    ,(110, (Taken, "99292"))
    ]

{- 実行結果
*Main> lockerLookup 101 lockers
Right "JAH3I"
*Main> lockerLookup 100 lockers
Left "Locker 100is already taken."
*Main> lockerLookup 102 lockers
Left "Locker 102 doesn't exist."
*Main> lockerLookup 110 lockers
Left "Locker 110is already taken."
*Main> lockerLookup 105 lockers
Right "JAH3I"
-}