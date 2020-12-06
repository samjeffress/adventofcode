module D04 where
  
import Data.List
import Data.Char
import Debug.Trace
import Data.List.Split
import Text.Regex.TDFA
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

betweenInclusive :: Int -> Int -> Int -> Bool
betweenInclusive lower upper candidate = 
  candidate >= lower && candidate <= upper

validateField :: String -> Bool
validateField fieldKeyAndValue = do
  let (key: value)  = splitOn ":" fieldKeyAndValue
  let fullValue = concat value
  case key of 
    "byr" -> betweenInclusive 1920 2002 (read fullValue)
    "iyr" -> betweenInclusive 2010 2020 (read fullValue)
    "eyr" -> betweenInclusive 2020 2030 (read fullValue)
    "hgt" -> if "cm" `isInfixOf` fullValue 
              then do
                let (cm:_) = splitOn "cm" fullValue
                betweenInclusive 150 193 (read cm)
              else do
                let (inch:_) = splitOn "in" fullValue
                betweenInclusive 59 76 (read inch)
    "hcl" -> fullValue =~ "(#[a-f0-9]{6})"
    "ecl" -> case fullValue of 
            "amb" -> True
            "blu" -> True
            "brn" -> True
            "gry" -> True
            "grn" -> True
            "hzl" -> True
            "oth" -> True
            _ -> False
    "pid" -> fullValue =~ "^[0-9]{9}$"
    _ -> False
    
validatePassport :: String -> Bool
validatePassport passport = do
  let tokens = splitOn " " passport
  let validationResult = filter validateField tokens
  length validationResult >= 7

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
  s >= 7
  
  
one = do 
  handle <- openFile "src/04input.txt" ReadMode  
  contents <- hGetContents handle
  let l = lines contents
  let validPassports = filter (passportIsValid requiredFields) (parsePassports l "" [])
  print (length validPassports)
  
  
two = do 
  handle <- openFile "src/04input.txt" ReadMode  
  contents <- hGetContents handle
  let l = lines contents
  let validPassports = filter (passportIsValid requiredFields) (parsePassports l "" [])
  print "validated:"
  print (length (filter validatePassport validPassports))
  
test = do
  let r = validatePassport "pid:252016128  ecl:gry byr:1952 iyr:2018 hcl:9016ff cid:158 hgt:161 eyr:1955"
  print r
  

test2 = do
  handle <- openFile "src/04.invalid.txt" ReadMode  
  contents <- hGetContents handle
  let l = lines contents
  let validPassports = filter (passportIsValid requiredFields) (parsePassports l "" [])
  print "validated:"
  print (length (filter validatePassport validPassports))

test3 = do
  handle <- openFile "src/04.valid.txt" ReadMode  
  contents <- hGetContents handle
  let l = lines contents
  let validPassports = filter (passportIsValid requiredFields) (parsePassports l "" [])
  print "validated:"
  print (length (filter validatePassport validPassports))
