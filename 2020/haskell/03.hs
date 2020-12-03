import Debug.Trace
import System.IO  
    
-- count of trees
-- number of positions across  
  
  
traverseSlope :: [String] -> Int -> Int -> Int
traverseSlope remainingLines treeCount position = do
  
  let current = head remainingLines
  let next = tail remainingLines
  let actualPosition = position `mod` length current
  
  let treeCountUpdated = if current !! actualPosition == '#' then treeCount + 1 else treeCount
  case next of
    []  -> treeCountUpdated 
    _   -> traverseSlope next treeCountUpdated (actualPosition + 3)
  
one = do 
  handle <- openFile "03input.txt" ReadMode  
  contents <- hGetContents handle
  let l = (lines contents)
  let treeCount = traverseSlope l 0 0
  print treeCount
  