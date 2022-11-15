## submission: gurbaaz singh nandra (190349)

def longest_arithmatic_progression arr
    n = arr.length
    longest_ap = []

    n.times { |i|
        (i+1..n-1).each { |j|
            common_difference = arr[j] - arr[i]
            last = arr[j]
            ap = [arr[i], arr[j]]
            (j+1..n-1).each { |k|
                if arr[k] - last == common_difference
                  ap.push arr[k]
                  last = arr[k]
                end
            }
            if ap.length >= longest_ap.length
              longest_ap = ap
            end
        }
    }
    longest_ap
end

puts "given an array of integers, returns the longest arithmetic progression (subsequence) in the list"
puts "array = [1, 10, 11, 20, 21, 22, 3, 23, 4, 5, -1]"
puts "================"
arr = [1,10,11,20,21,22,3,23,4,5,-1]
printf "longest ap: "
puts (longest_arithmatic_progression arr).join(", ")
puts "================"
