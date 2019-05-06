# 新しいデータ型を定義する

```
# Boolという型の定義
data Bool = False | True

# Intという型の定義
data Int = -2147483648 | -2147483647 | ... | -1 | 
           0 | 1 | 2 | ... | 2147483647
# 実際はこんな定義ではない。
```

`data`はデータ型を作成する際のHaskellのキーワード(予約語)

# レコード構文

Car.hsを参照

# 型引数

型コンストラクタは型を引数に取って新しい型を作るもの。

```
data Maybe a = Nothing | Just a
```

上記の`a`が型引数。そして型引数を取っているので`Maybe`は型コンストラクタと呼ばれる。
この型コンストラクタから`Maybe Int`, `Maybe Car`などの型を作ることができる。
単なるMaybeという型の値は存在することはできない。なぜなら、`Maybe`は型コンストラクタであって、型ではないからである。
型コンストラクタは、すべての引数を埋めて初めて何かしらの型になれます。

> My Note
> 型コンストラクタはジェネリCクスっぽい -> Class<T> でTが型引数

実はリスト型は型コンストラクタの一種。`[Int]`型の値、`[Char]`型の値、などはありますが、`[]`型の値というのは作れない。

`Nothing`の型が`Maybe a`であることに注意。この型は型引数がある、つまりMaybe aのaがあるので __多相的(polymorphic)__ である。

# 型シノニム

型シノニム(型同義名)そのものは特に何もしない。ある型に別の名前を与えて、コードやドキュメントを他の人が読みやすくするだけ。

```
type PhoneNumber = String
type Name = String
type PhoneBook = [(Name, PhoneNumber)]
```

Haskellプログラマは、自分のプログラムの中で使っている文字列について「ただの文字列じゃなくて実際はこれを表しているんだよ」という情報を伝えたいとき、Stringに型シノニムを与える。

# 型クラス中級講座

## Eq型クラスの内部

以下が標準ライブラリにおけるEqの定義です。

```
class Eq a where
    (==) :: a -> a -> Bool
    (/=) :: a -> a -> Bool
    x == y = not (x /= y)
    x /= y = not (x == y)
```

`class Eq a where`はEqという名前の新しい型クラスの定義が始めることを意味する。
型クラスの定義では関数定義の実体を与えなくても大丈夫。必要なのは型宣言(` :: `)のみ。
しかしこのEqの定義する関数は実体が実装されている(デフォルト実装)。
これは、この型クラスをインスタンス化する型が実装する際、`(==)`または`(/=)`のどちらか一方の実装をすればもう片方をする必要がないようにするためにある。これは、型クラスの**最小完全定義(minimal complete definition)**と呼ばれる概念である。

## サブクラス化

別の型クラスのサブクラスである型クラスを作ることもできる。

```
class (Eq a) Num => a where
```

これは、ある型をNumのインスタンスにしたかったら、その前にEqのインスタンスにする必要がある、と言っている。

## 多相型を型クラスのインスタンスに

MaybeをEqのインスタンスにしたい。

```
instance (Eq m) => Eq (Maybe m) where
    Just x == Just y = x == y
    Nothing == Nothing = True
    _ == _ = False
```

Maybeは型引数を1つ取って具体型を生み出す型コンストラクタ。`(Maybe m)`が型であり、インスタンス定義ではmを型の変数として扱うことができる。
このとき、そのmは`(==)`関数で比較されるべきなので`(Eq m) =>`として型制約をつけている。

# Functor型クラス

## List

Functorという型クラスを見ていこう。Functorは、**全体を写せる(map over)**ものの型クラスである。
リストのmapは何かを写す(map over)操作の典型例でリストはFunctor型クラスに属している。

Functor型クラスの実装は以下。

```
class Functor f where
    fmap :: (a -> b) -> f a -> a b
```

Functorは1つの関数fmapを持っており、デフォルト実装は提供していない。
Eq型クラスが`(==) :: (Eq a) => a -> a -> Bool`におけるaのようにすべて具体型であるのに対し、Functorのfは具体型ではないく、1つの型引数を取る型コンストラクタである。
fmapは「ある型aから別の型bへの関数」と「ある型aに適用されたファンクター値」を取り、「別の型bのほうに適用されたファンクター値」を返す関数。

map関数の型シグネチャを思い出そう。

```
map :: (a -> b) -> [a] -> [b]
```

**mapというのはリスト限定で動作するfmap**に過ぎない。リストに対するFunctorインスタンス宣言は以下。

```
instance Functor [] where
    fmap = map
```

`[]`は空のリストにではなく、リストを意味する型コンストラクタ。

```
Prelude> fmap (*2) [1..3]
[2,4,6]
Prelude> map (*2) [1..3]
[2,4,6]
```

## Maybe

Maybeもファンクターであり、以下のようになっている。

```
instance Functor Maybe where
    fmap f (Just x) = Just (f x)
    fmap f Nothing = Nothing
```

Maybeも型引数を1つ取る型コンストラクタなので`instance Functor Maybe where`とそのまま記述する。
> Ikeda note: `fmap f (Just x)`がの`f`がファンクター型コンストラクタの`f`と被って見えてややこしいが、これは`(a -> b)`の関数。

```
Prelude> fmap (*2) (Just 200)
Just 400
Prelude> fmap (*2) Nothing
Nothing
```

## Either

```
instance Functor (Either a) where
    fmap f (Right x) = Right (f x)
    fmap f (Left x) = Left x
```

Eitherの定義`data Either a b = Left a b`を見ると、`Either a`は型引数1つを取る型コンストラクタとなれるのでこれがFunctor型クラスのインスタンスになれる。
Leftにはfが適用されていないのは、fが`a -> b`でaを引数に取る関数であり、Eitherの定義からもわかるようにaとbは異なる型なので、fでa,b両方とも適用できてしまっては定義と矛盾してしまう。また、fmapがEither a bに作用したときの型を見ても、2つ目の引数は変化してもよいが、1つ目の引数は不変でないとまずいことが分かる(1つ目はエラーメッセージであったりする)。