-- Question 5
foldR :: (a -> b -> b) -> b -> [a] -> b
foldR _ a [] = a
foldR f a (x:xs) = f x (foldR f a xs)

map' :: (a -> b) -> [a] -> [b]
map' f a = foldR (\y ys -> (f y) : ys) [] a
