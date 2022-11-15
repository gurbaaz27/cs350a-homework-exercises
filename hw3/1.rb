## submission: gurbaaz singh nandra (190349)

def custom_reverse str
  n = str.length
  (n/2).times do |i|
    str[i], str[n-i-1] = str[n-i-1], str[i]
  end
  str
end

puts "Please input a string to reverse:"

str = gets

puts custom_reverse str