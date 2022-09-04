-- Question 3
merge :: Ord a => [a] -> [a] -> [a]
merge x y = remove_duplicate (merge' x y) where
  remove_duplicate [] = []
  remove_duplicate [x] = [x]
  remove_duplicate (x:y:xs) = if x == y 
                              then remove_duplicate (x : xs)
                              else x : (remove_duplicate (y : xs)) 
  merge' [] [] = []
  merge' (x:xs) [] = (x:xs)
  merge' [] (y:ys) = (y:ys)
  merge' (x:xs) (y:ys) = if x < y 
                         then x : merge' xs (y:ys)  
                         else x : merge' xs ys
