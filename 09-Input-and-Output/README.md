# I/Oアクションとは

I/Oアクションというのは値であり、Haskellの他の値とよく似ています。関数の引数として渡すことができて、関数の結果としてI/Oアクションを返すことができます。
I/Oアクションが特別なのは、main関数の中に入っていると(あるいはGHCiのプロンプトで評価されると)、それが実行されるところです。画面に何かを表示したりします。

# Haskell の return

Haskeでのreturnは、純粋な値からI/Oアクションを作り出します。
他の言語とは異なり、HaskellのreturnにはI/Oのdoブロックの実行を終わらせる働きはありません。