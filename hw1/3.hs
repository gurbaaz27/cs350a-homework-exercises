-- Question 3
merge :: Ord a => [a] -> [a] -> [a]
merge x y = remove_duplicate (merge' x y) where
  remove_duplicate [] = []
  remove_duplicate (x:xs) = x : remove_duplicate(filter (/= x) xs)

  merge' [] [] = []
  merge' (x:xs) [] = (x:xs)
  merge' [] (y:ys) = (y:ys)
  merge' (x:xs) (y:ys) | x < y  = x  : merge' xs (y:ys) 
                       | x > y  = y  : merge' (x:xs) ys
                       | x == y =  x : merge' xs ys  
