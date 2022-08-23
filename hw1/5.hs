foldR _ a [] = a
foldR f a (x:xs) = f x (foldR f a xs)

map' f a = foldR (\y ys -> (f y) : ys) [] a
