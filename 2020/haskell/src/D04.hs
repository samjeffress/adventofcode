module D04 where
  
import Data.List
import Data.Char
import Debug.Trace
import Data.List.Split
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

validate :: String -> Bool
validate passport = do
  let tokens = splitOn " " passport
  False
-- byr (Birth Year) - four digits; at least 1920 and at most 2002.
-- iyr (Issue Year) - four digits; at least 2010 and at most 2020.
-- eyr (Expiration Year) - four digits; at least 2020 and at most 2030.
-- hgt (Height) - a number followed by either cm or in:

--     If cm, the number must be at least 150 and at most 193.
--     If in, the number must be at least 59 and at most 76.

-- hcl (Hair Color) - a # followed by exactly six characters 0-9 or a-f.
-- ecl (Eye Color) - exactly one of: amb blu brn gry grn hzl oth.
-- pid (Passport ID) - a nine-digit number, including leading zeroes.

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