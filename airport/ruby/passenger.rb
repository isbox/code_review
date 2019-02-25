class Passenger
  attr_reader :take_time

  def initialize(take_time, vip)
    @vip = vip.rstrip
    @take_time = take_time
  end

  def vip?
    @vip == 'reward'
  end
end
