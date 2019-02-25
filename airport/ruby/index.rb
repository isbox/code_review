require './platform'
require './passenger'

print "输入你的出发时间: "
from_time = gets
print "你的乘坐类型: "
from_type = gets

print "输入你的返回时间: "
to_time = gets
print "你的乘坐类型: "
to_type = gets

passenger_from = Passenger.new from_time, true
platform_from = Platform.new 'Xian'

passenger_to = Passenger.new from_time, true
platform_to = Platform.new 'Chengdu'

trickets_from = platform_from.trip(passenger_from.take_time, passenger_from.vip?)
trickets_to = platform_to.trip(passenger_to.take_time, passenger_to.vip?)
p platform_from.best_one(trickets_from)
p platform_to.best_one(trickets_to)