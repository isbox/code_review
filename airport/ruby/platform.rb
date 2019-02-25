require './flight'

class Platform
  def initialize(from)
    flightsData = [
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
        'number' => 'GD2606',
        'from' => 'Xian',
        'to' => 'Chengdu',
        'time' => '12:25',
        'regular_weekdays_price' => 1600,
        'regular_weekends_price' => 600,
        'reward_weekdays_price' => 1100,
        'reward_weekends_price' => 500
      },
      {
        'number' => 'GD8732',
        'from' => 'Xian',
        'to' => 'Chengdu',
        'time' => '19:30',
        'regular_weekdays_price' => 2200,
        'regular_weekends_price' => 1500,
        'reward_weekdays_price' => 1000,
        'reward_weekends_price' => 400
      },
      {
        'number' => 'GD2502',
        'from' => 'Chengdu',
        'to' => 'Xian',
        'time' => '12:00',
        'regular_weekdays_price' => 1700,
        'regular_weekends_price' => 900,
        'reward_weekdays_price' => 800,
        'reward_weekends_price' => 900
      },
      {
        'number' => 'GD2607',
        'from' => 'Chengdu',
        'to' => 'Xian',
        'time' => '16:25',
        'regular_weekdays_price' => 1600,
        'regular_weekends_price' => 600,
        'reward_weekdays_price' => 1100,
        'reward_weekends_price' => 500
      },
      {
        'number' => 'GD8733',
        'from' => 'Chengdu',
        'to' => 'Xian',
        'time' => '23:30',
        'regular_weekdays_price' => 1600,
        'regular_weekends_price' => 1000,
        'reward_weekdays_price' => 1500,
        'reward_weekends_price' => 400
      }
    ]
    @flights = []
    @tickets = []
    flightsData.each do |flight|
      @flights.push Flight.new flight if flight['from'] == from
    end
  end

  def trip(time, vip)
    @flights.each do |flight|
      @tickets.push flight.todyPrice(time, vip)
    end
    @tickets
  end

  def best_one(trips)
    cheap_trickets = []
    trips.each do |trip|
      if cheap_trickets.size == 0 || cheap_trickets[0][:price] == trip[:price]
        cheap_trickets.push(trip)
      elsif cheap_trickets[0][:price] > trip[:price]
        cheap_trickets = []
        cheap_trickets.push(trip)
      end
    end

    return cheap_trickets[0] if cheap_trickets.size == 1
    
    best = []
    cheap_trickets.each do |cheap_tricket|
      time_abs = (12 - cheap_tricket[:time].split(':')[0].to_i).abs
      if best.empty? || time_abs < best[0]
        best[0] = time_abs
        best[1] = cheap_tricket
      end
    end
    best[1]
  end
end