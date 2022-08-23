a = [i | i <- [0..], i `mod` 2 == 0 || i `mod` 3 == 0 || i `mod` 5 == 0]


multiplesOf k n = n:multiplesOf k (n+k) 

merge (x:xs) (y:ys) | x < y  = x:merge xs (y:ys) 
                    | x > y  = y:merge (x:xs) ys 
                    | x == y = x:merge xs ys

b = merge (merge (multiplesOf 2 0)  (multiplesOf 3 0)) (multiplesOf 5 0)
