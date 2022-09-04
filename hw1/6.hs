-- Question 6
a = [i | i <- [0..], i `mod` 2 == 0 || i `mod` 3 == 0 || i `mod` 5 == 0]

multiplesOf :: Num t => t -> t -> [t]
multiplesOf k n = n:multiplesOf k (n+k) 

stream_merge :: Ord a => [a] -> [a] -> [a]
stream_merge (x:xs) (y:ys) | x < y  = x:stream_merge xs (y:ys) 
                           | x > y  = y:stream_merge (x:xs) ys 
                           | x == y = x:stream_merge xs ys

b = stream_merge (stream_merge (multiplesOf 2 0)  (multiplesOf 3 0)) (multiplesOf 5 0)
