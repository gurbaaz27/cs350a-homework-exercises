-- Question 1
takeAlternate :: (Eq t, Num t) => t -> [a] -> [a]
takeAlternate n [] = []
takeAlternate 1 (x:xs) = [x]
takeAlternate n [x] = [x]
takeAlternate n (x:y:xs) = (x : (takeAlternate (n-1) xs))
