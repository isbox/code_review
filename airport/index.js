const moment = require('moment');
const inquirer = require('inquirer');

const TO_XIAN = [
  {
    flightNumber: 'GD2501',
    time: '08:00',
    from: 'Xian',
    to: 'Chengdu',
    normalPrice: {
      weekdays: 1100,
      weekends: 900
    },
    rewardPrice: {
      weekdays: 800,
      weekends: 500
    }
  },
  {
    flightNumber: 'GD2606',
    time: '12:25',
    from: 'Xian',
    to: 'Chengdu',
    normalPrice: {
      weekdays: 1600,
      weekends: 600
    },
    rewardPrice: {
      weekdays: 1100,
      weekends: 500
    }
  },
  {
    flightNumber: 'GD8732',
    time: '19:30',
    from: 'Xian',
    to: 'Chengdu',
    normalPrice: {
      weekdays: 2200,
      weekends: 1500
    },
    rewardPrice: {
      weekdays: 1000,
      weekends: 400
    }
  }  
];

const TO_CHENGDU = [
  {
    flightNumber: 'GD2502',
    time: '12:00',
    from: 'Chengdu',
    to: 'Xian',
    normalPrice: {
      weekdays: 1700,
      weekends: 900
    },
    rewardPrice: {
      weekdays: 800,
      weekends: 800
    }
  },
  {
    flightNumber: 'GD2607',
    time: '16:25',
    from: 'Chengdu',
    to: 'Xian',
    normalPrice: {
      weekdays: 1600,
      weekends: 600
    },
    rewardPrice: {
      weekdays: 1100,
      weekends: 500
    }
  },
  {
    flightNumber: 'GD8733',
    time: '23:30',
    from: 'Chengdu',
    to: 'Xian',
    normalPrice: {
      weekdays: 1600,
      weekends: 1500
    },
    rewardPrice: {
      weekdays: 1000,
      weekends: 400
    }
  }  
];

const min = function(arr) {
  return Math.min.apply(null, [...arr])
}

const bestOne = function(arr) {
  if (arr.length < 2) {
    return arr[0];
  }
  let times = [];
  let recordIndex = {};
  arr.map((res, index) => {
    const travelTime = res.travelTo.time.split(':');
    const returnTime = res.return.time.split(':');
    const timeSub = Math.abs(12 * 60 * 2 - Number(travelTime[0]) * 60 + Number(travelTime[1]) + Number(returnTime[0]) * 60 + Number(returnTime[1]));
    recordIndex[timeSub] = index;
  })
  
  const best = min(times);
  return arr[best];
}

const flightSelect = function(outTime, returnTime, vip = false) {
  let result = [];
  let prices = [];
  const isOutWeekends = moment(outTime).weekday() > 5 ? 'weekdays' : 'weekends';
  const isReturnWeekends = moment(returnTime).weekday() > 5 ? 'weekdays' : 'weekends';
  const usePrice = vip ? 'rewardPrice' : 'normalPrice';

  for (const outData of TO_XIAN) {
    const price1 = outData[usePrice][isOutWeekends];
    for (const returnData of TO_CHENGDU) {
      const price2 = returnData[usePrice][isReturnWeekends];
      prices.push(price1 + price2);
      result.push({
        travelTo: {
          flightNumber: outData.flightNumber,
          price: price1,
          time: outData.time
        },
        return: {
          flightNumber: returnData.flightNumber,
          price: price2,
          time: returnData.time
        },
        total: price1 + price2
      })
    }
  }

  const minPrice = min(prices);
  result = result.filter(res => res.total === minPrice);
  console.log(bestOne(result));
};

inquirer.prompt([{
  type: 'input',
  name: 'travelTime',
  message: '输入出发日期（YYYY-mm-dd）：'
}, {
  type: 'input',
  name: 'backTime',
  message: '输入返回日期（YYYY-mm-dd）：'
}, {
  type: 'input',
  name: 'vip',
  message: '是否是vip乘客：'
}]).then(function (answers) {
  const { travelTime, backTime, vip } = answers;
  flightSelect(travelTime, backTime, vip);
});