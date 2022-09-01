merge [] [] = []
merge (x:xs) [] = (x:xs)
merge [] (y:ys) = (y:ys)
merge (x:xs) (y:ys) = if x < y 
                      then x : merge xs (y:ys)  
                      else x : merge xs ys
