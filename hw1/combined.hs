takeAlternate n [] = []
takeAlternate 1 (x:xs) = [x]
takeAlternate n [x] = [x]
takeAlternate n (x:y:xs) = (x : (takeAlternate (n-1) xs))
last' [] = error "empty list"
last' [x] = x
last' (x:xs) = last' xs
merge [] [] = []
merge (x:xs) [] = (x:xs)
merge [] (y:ys) = (y:ys)
merge (x:xs) (y:ys) = if x < y 
                      then x : merge xs (y:ys)  
                      else x : merge xs ys
zip' [] [] = []
zip' (x:xs) [] = []
zip' [] (y:ys) = [] 
zip' (x:xs) (y:ys) = (x,y) : (zip' xs ys)

zipWith' _ [] [] = []
zipWith' _ (x:xs) [] = []
zipWith' _ [] (y:ys) = [] 
zipWith' f (x:xs) (y:ys) = (f x y) : (zipWith' f xs ys)
foldR _ a [] = a
foldR f a (x:xs) = f x (foldR f a xs)

map' f a = foldR (\y ys -> (f y) : ys) [] a
a = [i | i <- [0..], i `mod` 2 == 0 || i `mod` 3 == 0 || i `mod` 5 == 0]


multiplesOf k n = n:multiplesOf k (n+k) 

stream_merge (x:xs) (y:ys) | x < y  = x:stream_merge xs (y:ys) 
                           | x > y  = y:stream_merge (x:xs) ys 
                           | x == y = x:stream_merge xs ys

b = stream_merge (stream_merge (multiplesOf 2 0)  (multiplesOf 3 0)) (multiplesOf 5 0)
