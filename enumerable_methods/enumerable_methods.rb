module Enumerable
  def my_each
    return unless block_given?

    for i in self
      yield i
    end
  end

  def my_each_with_index
    return unless block_given?

    index = 0
    for i in self
      yield i, index
      index += 1
    end
  end

  # [1, 2, 3, 4].my_select(&:even?)
  # => [2, 4]
  def my_select
    return unless block_given?

    array = []
    my_each { |x| array << x if yield x }

    array
  end

  # [2, 4].my_all?(&:even?)
  # => true
  # [1, 2, 4].my_all?(&:even?)
  # => false
  def my_all?
    return unless block_given?

    result = my_select { |x| yield x }

    length == result.length
  end

  # [1, 2, 3].my_any?(&:even?)
  # => true
  # [1, 3, 5].my_any?(&:even?)
  # => false
  def my_any?
    return unless block_given?

    result = my_select { |x| yield x }

    result.length.positive?
  end

  # [1, 2, 3].my_none?(&:even?)
  # => false
  # [1, 3, 5].my_none?(&:even?)
  # => true
  def my_none?
    return unless block_given?

    !my_any?
  end

  # [1, 2, 3].count
  # => 3
  # [1, 2, 3].count(2)
  # => 2
  # [1, 3, 5].my_count? { |x| x > 1 }
  # => 2
  def my_count(count = nil)
    return count if count
    return length unless block_given?

    my_select { |x| yield x }.length
  end

  # [1,2,3,4,5].my_map { |x| x * 2 }
  # [1,2,3,4,5].my_map(Proc.new({ |x| x * 2 }))
  # => [2, 4, 6, 8, 10]
  def my_map(my_proc = nil)
    array = []
    my_each { |x| array << my_proc.call(x) } if my_proc
    my_each { |x| array << yield(x) } if block_given?

    array
  end

  # (5..10).my_inject(:+)
  # (5..10).my_inject { |sum, n| sum + n }
  # => 45
  # (5..10).my_inject(1, :*)
  # (5..10).my_inject(1) { |product, n| product * n }
  # => 151200
  def my_inject(*args)
    case args.length
      when 1 then args.first.is_a?(Symbol) ? sym = args.first : result = args.first
      when 2 then result, sym = args.first, args.last
    end

    result ||= 0

    my_each { |x| result = block_given? ? yield(result, x) : result.send(sym, x) }

    result
  end

  # [2,4,5].multiply_els
  # => 40
  def multiply_els
    my_inject(1, :*)
  end
end
