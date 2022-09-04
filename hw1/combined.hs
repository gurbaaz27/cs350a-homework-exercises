-- Submission by: Gurbaaz Singh Nandra | 190349 | gurbaaz@iitk.ac.in
-- Question 1
takeAlternate :: (Eq t, Num t) => t -> [a] -> [a]
takeAlternate n [] = []
takeAlternate 1 (x:xs) = [x]
takeAlternate n [x] = [x]
takeAlternate n (x:y:xs) = (x : (takeAlternate (n-1) xs))
-- Question 2
last' :: [a] -> a
last' [] = error "empty list"
last' [x] = x
last' (x:xs) = last' xs
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
-- Question 4
zip' :: [a] -> [b] -> [(a,b)]
zip' [] [] = []
zip' (x:xs) [] = []
zip' [] (y:ys) = [] 
zip' (x:xs) (y:ys) = (x,y) : (zip' xs ys)

zipWith' :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWith' _ [] [] = []
zipWith' _ (x:xs) [] = []
zipWith' _ [] (y:ys) = [] 
zipWith' f (x:xs) (y:ys) = (f x y) : (zipWith' f xs ys)
-- Question 5
foldR :: (a -> b -> b) -> b -> [a] -> b
foldR _ a [] = a
foldR f a (x:xs) = f x (foldR f a xs)

map' :: (a -> b) -> [a] -> [b]
map' f a = foldR (\y ys -> (f y) : ys) [] a
-- Question 6
a = [i | i <- [0..], i `mod` 2 == 0 || i `mod` 3 == 0 || i `mod` 5 == 0]

multiplesOf :: Num t => t -> t -> [t]
multiplesOf k n = n:multiplesOf k (n+k) 

stream_merge :: Ord a => [a] -> [a] -> [a]
stream_merge (x:xs) (y:ys) | x < y  = x:stream_merge xs (y:ys) 
                           | x > y  = y:stream_merge (x:xs) ys 
                           | x == y = x:stream_merge xs ys

b = stream_merge (stream_merge (multiplesOf 2 0)  (multiplesOf 3 0)) (multiplesOf 5 0)
