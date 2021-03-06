data Tree a = EmptyTree | Node a (Tree a) (Tree a) deriving (Show)

-- singletonは要素が1つしかない木を作るための補助関数
singleton :: a -> Tree a
singleton x = Node x EmptyTree EmptyTree

-- treeInsertは要素xを木に挿入するための関数
treeInsert :: (Ord a) => a -> Tree a -> Tree a
treeInsert x EmptyTree = singleton x
treeInsert x (Node a left right)
    | x == a = Node x left right
    | x < a = Node a (treeInsert x left) right
    | x > a = Node a left (treeInsert x right)

-- treeElemはある要素が木に属しているかを判定する関数
treeElem :: (Ord a) => a -> Tree a -> Bool
treeElem x EmptyTree = False
treeElem x (Node a left right)
    | x == a = True
    | x < a = treeElem x left
    | x > a = treeElem x right

{-
*Main> let nums = [8, 3, 5, 9, 2]
*Main> let numTree = foldr treeInsert EmptyTree nums
*Main> numTree 
Node 2 EmptyTree (Node 9 (Node 5 (Node 3 EmptyTree EmptyTree) (Node 8 EmptyTree EmptyTree)) EmptyTree)
-}

instance Functor Tree where
    fmap f EmptyTree = EmptyTree
    fmap f (Node x left right) = Node (f x) (fmap f left) (fmap f right)

{-
*Main> let myTree = foldr treeInsert EmptyTree [5,7,3]
*Main> myTree 
Node 3 EmptyTree (Node 7 (Node 5 EmptyTree EmptyTree) EmptyTree)
*Main> fmap (*4) myTree 
Node 12 EmptyTree (Node 28 (Node 20 EmptyTree EmptyTree) EmptyTree)
-}