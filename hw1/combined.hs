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
  remove_duplicate (x:xs) = x : remove_duplicate(filter (/= x) xs)

  merge' [] [] = []
  merge' (x:xs) [] = (x:xs)
  merge' [] (y:ys) = (y:ys)
  merge' (x:xs) (y:ys) | x < y  = x  : merge' xs (y:ys) 
                       | x > y  = y  : merge' (x:xs) ys
                       | x == y =  x : merge' xs ys  
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
-- a : using list comprehension
a = [i | i <- [0..], i `mod` 2 == 0 || i `mod` 3 == 0 || i `mod` 5 == 0]

multiplesOf :: Num t => t -> t -> [t]
multiplesOf k n = n:multiplesOf k (n+k) 

stream_merge :: Ord a => [a] -> [a] -> [a]
stream_merge (x:xs) (y:ys) | x < y  = x:stream_merge xs (y:ys) 
                           | x > y  = y:stream_merge (x:xs) ys 
                           | x == y = x:stream_merge xs ys

-- b :  using self-referential streams
b = stream_merge (stream_merge (multiplesOf 2 0)  (multiplesOf 3 0)) (multiplesOf 5 0)

inf_stream x = if x `mod` 2 == 0 || x `mod` 3 == 0 || x `mod` 5 == 0
               then x : inf_stream (x+1)
               else inf_stream (x+1)

-- alt_b : alternate way of producing stream using self-referential streams
alt_b = inf_stream 0
