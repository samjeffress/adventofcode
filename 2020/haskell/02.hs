import Debug.Trace
import Text.Read
import Data.Char
import qualified Data.Text as T
import System.IO  


data Password = Password {requiredLetter :: Char, minimumOccurance :: Int, maximumOccurance :: Int, password :: String } deriving (Show)

-- partOne :: Int
-- partOne = do
--   let lines = words . head . lines <$> readFile "02passwords.txt"
--   0
  
parseValidPassword :: String -> Bool
parseValidPassword line = do 
  case words line of 
    [a, b, c] -> do
      let aParts =  T.splitOn (T.pack "-") (T.pack a)
      let requiredLetter = head b 
      let minimumOccurance = read (T.unpack (head aParts))
      let maximumOccurance = read (T.unpack (last aParts))
      let password=c-- right number of params
      let matchingLetters = filter (== requiredLetter) password
      length matchingLetters >= minimumOccurance && length matchingLetters <= maximumOccurance
    _ -> False
  
one = do 
  handle <- openFile "02passwords.txt" ReadMode  
  contents <- hGetContents handle  
  let validPasswords = filter (==True) (map parseValidPassword (lines contents))
  print (length validPasswords)
  