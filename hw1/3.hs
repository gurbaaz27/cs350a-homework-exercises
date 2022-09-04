-- Question 3
merge :: Ord a => [a] -> [a] -> [a]
merge x y = remove_duplicate (merge' x y) where
  remove_duplicate [] = []
  remove_duplicate (x:xs) = x : remove_duplicate(filter (/= x) xs)
  
  merge' [] [] = []
  merge' (x:xs) [] = (x:xs)
  merge' [] (y:ys) = (y:ys)
  merge' (x:xs) (y:ys) = if x < y 
                         then x : merge' xs (y:ys)  
                         else x : merge' xs ys
