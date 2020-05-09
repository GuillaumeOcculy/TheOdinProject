list = [4, 3, 78, 2, 0, 2]

def bubble_sort(array)
  array.length.times do
    array.each_with_index do |i, index|
      next if index +1 == array.length

      array[index], array[index+1] = array[index+1], array[index] if array[index] > array[index+1]
    end
  end

  array
end

p bubble_sort(list)
# [0, 2, 2, 3, 4, 78]

def bubble_sort_by(array)
  array.length.times do
    array.each_with_index do |i, index|
      next if index + 1 == array.length

      left, right = array[index], array[index + 1]
      array[index], array[index+1] = right, left if yield(left, right).positive?
    end
  end
  p array
  # ["hi", "hey", "hello"]
end

bubble_sort_by(['hi', 'hello', 'hey']) do |left, right|
  left.length - right.length
end
