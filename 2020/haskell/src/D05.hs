module D05 where
import System.IO  
import Data.List

valueOfChar :: Int -> Char -> Int
valueOfChar base char =
  if char == 'B' || char == 'R' then base else 0

rowValue :: String -> (Int, String)
rowValue rowData = 
  case rowData of
    (a:b:c:d:e:f:g:h:i:j) -> (8 * sum [
        valueOfChar 64 a,
        valueOfChar 32 b,
        valueOfChar 16 c,
        valueOfChar 8 d,
        valueOfChar 4 e,
        valueOfChar 2 f,
        valueOfChar 1 g
      ] + sum [
        valueOfChar 4 h,
        valueOfChar 2 i,
        valueOfChar 1 (last j)
      ], rowData)
    _ -> (0, rowData) 

one = do 
  handle <- openFile "src/05input.txt" ReadMode  
  contents <- hGetContents handle
  let l = lines contents
  let values = sort (map rowValue l)
  print (maximum values)