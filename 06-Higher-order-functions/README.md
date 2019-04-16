# カリー化とは

カリー化関数は、複数の引数を取る代わりに、常にちょうど1つの引数を取る関数。

```
Prelude> :t max
max :: Ord a => a -> a -> a
```

maxは2つの引数を受け取り、aを返す関数 (a -> a) -> a とみなすこともできるが  
1つの引数を受け取り、"aを引数としてaを返す関数"を返す関数 a -> (a -> a) とみなすこともできる。


```
multThree :: Int -> Int -> Int -> Int
multThree x y z = x * y * z
```

このとき

```
Prelude> let multTwoWithNine = multThree 9
Prelude> multTwoWithNine 2 3
54
```

である。  
`multTwoWithNine`は2つの引数を取る関数。

# セクション

```
divideByTen :: (Floating a) => a -> a
divideByTen = (/10)
```

このように演算子などで x/y と片側がない(xがない or yがない)ような昨日はセクション呼ばれ部分適用となる。

```
Prelude> divideByTen 200
20.0
```

# 畳み込み

```
Prelude> :t foldl
foldl :: Foldable t => (b -> a -> b) -> b -> t a -> b
Prelude> :t foldr
foldr :: Foldable t => (a -> b -> b) -> b -> t a -> b
```

リスト[3,4,5,6]を畳み込むとき

### 右畳み込み

```
f 3 (f 4 (f 5 (f 6 z)))
```

このときfが
f 3 _ = 100
なパターンマッチな関数だとすると
f 3 (... の時点で100を返すので、右畳み込みは無限リストに対応した畳み込みと言うことができる(らしい)

リストがアキュムレータの関数のとき一般的に右畳み込みが使われる。

### 左畳み込み

```
g (g (g (g z 3) 4) 5) 6
```

右畳み込みと違い、左畳み込みは無限リストに対応できない。


# $を使った関数適用

`$`の定義

```
($) :: (a -> b) -> a -> b
f $ x = f x
```

普通の関数適用(2つのものの間に空白を置く)は左結合(f a b cは((f a) b )cを意味する)が、$による関数適用は右結合。

````
Prelude> sum (filter (> 10) (map (*2) [2..10]))
80
Prelude> sum $ filter (> 10) $ map (*2) [2..10]
80
````

括弧を削除する話とは別に、$は関数適用それ自身を関数として扱えるようにするために使える。

```
Prelude> map ($3) [(4+), (10*), (^2), sqrt, (\x -> x * x)]
[7.0,30.0,9.0,1.7320508075688772,9.0]
```

# 関数合成

(.)の定義

```
(.) :: (b -> c) -> (a -> b) -> a -> c
f . g = \x -> f (g x)
```

```
Prelude> map (\x -> negate (abs x)) [1, -3, 5, -4, -2]
[-1,-3,-5,-4,-2]
Prelude> map (negate . abs) [1, -3, 5, -4, -2]
[-1,-3,-5,-4,-2]
```

## ポイントフリースタイル

ポイントフリースタイルとは
fn x = f (g x) のような関数定義に登場する一時変数xを利用しないやりかたのこと。

例

```
fn x = ceiling (negate (tan (cos max 50 x)))
```
を
```
fn = ceiling . negate . tan . cos . max 50
```
とかける。xをなくすことができたのでポイントフリースタイルである。