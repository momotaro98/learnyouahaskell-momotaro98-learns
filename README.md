# How to compile Haskell code and run

```hello.hs
main = putStrLn "Hello World"
```

```bash
$ ghc --make helloWorld
$ ./helloWorld
```

# Load Haskell file from ghci

```
$ ghci
> :l fact
Main> factorial 50
```
