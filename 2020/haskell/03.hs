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

traverseSlope2 :: [String] -> Int -> Int -> Int -> Bool -> Int
traverseSlope2 remainingLines treeCount position moveRight skipNext = do
  
  let current = head remainingLines
  let next = tail remainingLines
  let actualPosition = position `mod` length current
  let treeCountUpdated = if current !! actualPosition == '#' then treeCount + 1 else treeCount
  if skipNext then 
    case next of
      []  -> treeCountUpdated 
      [n] -> treeCountUpdated
      _   -> traverseSlope2 (tail next) treeCountUpdated (actualPosition + moveRight) moveRight skipNext
  else 
    case next of
      []  -> treeCountUpdated 
      _   -> traverseSlope2 next treeCountUpdated (actualPosition + moveRight) moveRight skipNext
  
one = do 
  handle <- openFile "03input.txt" ReadMode  
  contents <- hGetContents handle
  let l = lines contents
  let treeCount = traverseSlope l 0 0
  print treeCount
  
  
two = do 
  handle <- openFile "03input.txt" ReadMode  
  contents <- hGetContents handle
  let l = lines contents
  let total = product [ traverseSlope2 l 0 0 1 False,
                        traverseSlope2 l 0 0 3 False,
                        traverseSlope2 l 0 0 5 False,
                        traverseSlope2 l 0 0 7 False,
                        traverseSlope2 l 0 0 1 True
                      ]
  print total
  