## submission: gurbaaz singh nandra (190349)

class Array
  def foldl id, &block
      if block_given?
          self.each {|e| id = yield id, e}
      end
      id
  end
end

puts "foldl implementation for ruby arrays"
puts "array = [1,4,9,16,25]"
arr = [1,4,9,16,25]
puts "================"
puts "block (anonymous lambda function) used in this example is (\\ x y . x + y), id = 0"
puts arr.foldl(0) { |x, y| x + y}
puts "================"
puts "block (anonymous lambda function) used in this example is (\\ x y . x * y), id = 1"
puts arr.foldl(1) { |x, y| x * y}
puts "================"
puts "no block (anonymous lambda function) given for this array, id = 5"
puts arr.foldl(5)
puts "================"
