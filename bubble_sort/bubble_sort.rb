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
