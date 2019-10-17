STOCK_PRICES = [17, 3, 6, 9, 15, 8, 6, 1, 10]

best_days = [0, 0]

STOCK_PRICES.each_with_index do |day, index|
  array_to_buy = STOCK_PRICES[index..-1]
  array_to_sell = STOCK_PRICES[index+1..-1]

  max_to_buy = array_to_buy.max
  max_to_sell = array_to_sell.max

  next if max_to_buy == day
  next if max_to_sell <= day

  temp = [day, max_to_sell]

  result = temp.reduce(:-)
  result = result.abs

  best_day_result = best_days.reduce(:-).abs

  if best_day_result < result
    best_days = temp
  end
end

Day = Struct.new(:days) do
  def buy
    days[0]
  end

  def sell
    days[1]
  end

  def result
    [STOCK_PRICES.index(buy), STOCK_PRICES.index(sell)]
  end
end

day = Day.new(best_days)
p day.result
