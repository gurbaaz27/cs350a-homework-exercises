last' [] = error "empty list"
last' [x] = x
last' (x:xs) = last' xs
