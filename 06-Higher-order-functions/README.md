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
