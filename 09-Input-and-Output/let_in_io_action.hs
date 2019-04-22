import Data.Char

main = do
    putStrLn "What's your first name?"
    firstName <- getLine
    putStrLn "What's your last name?"
    lastName <- getLine
    let bigFirstName = map toUpper firstName
        bigLastName = map toUpper lastName
    putStrLn $ "hey " ++ bigFirstName ++ " "
                      ++ bigLastName
                      ++ ", how are you?"

{-
$ ./let_in_io_action
What's your first name?
Ikeda
What's your last name?
Shintaro
hey IKEDA SHINTARO, how are you?
-}
