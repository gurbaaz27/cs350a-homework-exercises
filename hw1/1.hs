takeAlternate n [] = []
takeAlternate 1 (x:xs) = [x]
takeAlternate n [x] = [x]
takeAlternate n (x:y:xs) = (x : (takeAlternate (n-1) xs))
