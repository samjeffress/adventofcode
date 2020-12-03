import Debug.Trace
import qualified Data.Text as T
import System.IO  
  
parseValidPassword :: String -> Bool
parseValidPassword line = do 
  case words line of 
    [a, b, c] -> do
      let aParts =  T.splitOn (T.pack "-") (T.pack a)
      let requiredLetter = head b 
      let minimumOccurance = read (T.unpack (head aParts))
      let maximumOccurance = read (T.unpack (last aParts))
      let password = c
      let matchingLetters = filter (== requiredLetter) password
      length matchingLetters >= minimumOccurance && length matchingLetters <= maximumOccurance
    _ -> False
    
xor :: Bool -> Bool -> Bool
xor a b | a && not b = True
        | not a && b  = True
        | otherwise = False
    
parseValidPart2Password :: String -> Bool
parseValidPart2Password line = do 
  case words line of 
    [a, b, c] -> do
      let aParts =  T.splitOn (T.pack "-") (T.pack a)
      let requiredLetter = head b 
      let firstIndex = read (T.unpack (head aParts)) - 1
      let secondIndex = read (T.unpack (last aParts)) - 1
      let password = c
      let result = xor (password !! firstIndex == requiredLetter)  (password !! secondIndex == requiredLetter)
      trace ("requiredletter " ++ show requiredLetter ++  " letters "  ++ show (password !! firstIndex) ++ " " ++ show (password !! secondIndex) ++ " result " ++ show result) result
    _ -> False
  
one = do 
  handle <- openFile "02passwords.txt" ReadMode  
  contents <- hGetContents handle  
  let validPasswords = filter (==True) (map parseValidPassword (lines contents))
  print (length validPasswords)
  
two  = do 
  handle <- openFile "02passwords.txt" ReadMode  
  contents <- hGetContents handle  
  let validPasswords = filter (==True) (map parseValidPart2Password (lines contents))
  print (length validPasswords)