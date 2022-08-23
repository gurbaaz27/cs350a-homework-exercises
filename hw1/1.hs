takeAlternate n [] = []
takeAlternate 0 (x:xs) = []
takeAlternate n (x:y:xs) = (x : (takeAlternate (n-1) xs))
