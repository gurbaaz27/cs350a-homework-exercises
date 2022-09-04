-- Question 2
last' :: [a] -> a
last' [] = error "empty list"
last' [x] = x
last' (x:xs) = last' xs
