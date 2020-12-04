import Data.List
import Data.Char
import Debug.Trace
import System.IO  

requiredFields :: [String]
requiredFields = [ 
    "byr",
    "iyr",
    "eyr",
    "hgt",
    "hcl",
    "ecl",
    "pid"
    -- ,"cid"
  ]

toLowerString :: String -> String
toLowerString = 
  map toLower

parsePassports :: [String] -> String -> [String] -> [String]
parsePassports fileLines currentPassport collatedPassports = do
  let h = head fileLines
  if not (null (tail fileLines)) then 
    case h of 
      "" -> parsePassports (tail fileLines) "" (collatedPassports ++ [toLowerString currentPassport])
      _  -> parsePassports (tail fileLines) (currentPassport ++ " " ++ h) collatedPassports
  else 
    case h of 
      "" ->  collatedPassports ++ [currentPassport]
      _  ->  collatedPassports ++ [currentPassport ++ " " ++ h]
  
returnOneIfStringIsInString :: String -> String -> Int  
returnOneIfStringIsInString needle haystack  = do
  if (needle ++ ":") `isInfixOf` haystack then 1 else 0
  
  
passportIsValid :: [String] -> String -> Bool
passportIsValid requiredFields passport  = do
  let s = sum (map (\r -> returnOneIfStringIsInString r passport) requiredFields)
  if s >= 7 then 
    trace (show s ++ " " ++ passport) True
  else 
    trace (show s ++ " " ++ passport) False
  
  
one = do 
  handle <- openFile "04input.txt" ReadMode  
  contents <- hGetContents handle
  let l = lines contents
  let validPassports = filter (passportIsValid requiredFields) (parsePassports l "" [])
  print (length validPassports)
  
  
-- > 244
-- < 291