class YesNo a where
    yesno :: a -> Bool

-- YesNoはJavaScriptっぽい真偽処理をするための型クラス

-- 以降YesNo型クラスのインスタンス定義

instance YesNo Int where
    yesno 0 = False
    yesno _ = True

instance YesNo ([] a) where -- 本当は`YesNo [a]`でも良いのだが、`[]`が型クラス であることを強調するためにこの書き方にした。
    yesno [] = False
    yesno _ = True

instance YesNo Bool where
    yesno = id -- idは引数を1つ取っても同じものを返すだけの標準ライブラリ`id :: a -> a`

instance YesNo (Maybe a) where
    yesno (Just _) = True
    yesno Nothing = False
-- Maybe a型がEq型クラスのインスタンスになる際は
-- `instance (Eq a) => Eq (Maybe a) where`のように型クラス制約があるが今回は不要。

{- 実行結果
*Main> yesno $ length []
False
*Main> yesno "haha"
True
*Main> yesno True
True
*Main> yesno $ Just 10
True
-}