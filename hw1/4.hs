zip' [] [] = []
zip' (x:xs) [] = []
zip' [] (y:ys) = [] 
zip' (x:xs) (y:ys) = (x,y) : (zip' xs ys)

zipWith' _ [] [] = []
zipWith' _ (x:xs) [] = []
zipWith' _ [] (y:ys) = [] 
zipWith' f (x:xs) (y:ys) = (f x y) : (zipWith' f xs ys)
