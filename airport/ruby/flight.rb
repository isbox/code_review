require 'date'

flight = [
  {
    'number' => 'GD2501',
    'from' => 'Xian',
    'to' => 'Chengdu',
    'time' => '08:00',
    'regular_weekdays_price' => 1100,
    'regular_weekends_price' => 900,
    'reward_weekdays_price' => 800,
    'reward_weekends_price' => 500
  },
  {
    'number' => 'GD2501',
    'from' => 'Xian',
    'to' => 'Chengdu',
    'time' => '08:00',
    'regular_weekdays_price' => 1100,
    'regular_weekends_price' => 900,
    'reward_weekdays_price' => 800,
    'reward_weekends_price' => 500
  }
]

class Flight
  # attr_accessor :regular_weekdays_price, :regular_weekends_price, :reward_weekdays_price, :reward_weekends_price

  def initialize(flight)
    @flight_number = flight['number']
    @from = flight['from']
    @to = flight['to']
    @time = flight['time']
    @regular_weekdays_price = flight['regular_weekdays_price']
    @regular_weekends_price = flight['regular_weekends_price']
    @reward_weekdays_price = flight['reward_weekdays_price']
    @reward_weekends_price = flight['reward_weekends_price']
  end
  
  def todyPrice(time, vip)
    price = 0
    weekdays = ['Sat', 'Sun']
    departTime = DateTime.parse(time).strftime('%a, %Y-%m-%d').split(',')
    departTime = departTime[0]
    day_type = (weekdays.include? departTime) ? 'weekends' : 'weekdays'
    
    if day_type == 'weekends'
      price = vip ? @reward_weekends_price : @regular_weekends_price
    else
      price = vip ? @reward_weekdays_price : @regular_weekdays_price
    end

    return {
      :flight_number => @flight_number,
      :price => price,
      :from => @from,
      :to => @to,
      :time => @time
    }
  end
end
