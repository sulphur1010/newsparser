getRandomArbitary = (min, max) ->
  Math.floor Math.random() * (max - min) + min

rotate = ->
  arr = [
    299.89
    315.32
    278.91
    289.99
  ]
  index = getRandomArbitary(0, arr.length - 1)
  index = getRandomArbitary(0, arr.length - 1)  while @last is index
  @last = index
  $(".ticker").text arr[index]
 
  return

loadOdometer = ->
  ticker = $(".ticker")
  if ticker.length
    od = new Odometer(
      el: ticker.get(0)
      value: 300.19
    )
  rotate
  clearInterval window.rtr
  window.rtr=setInterval rotate, 5000
  return

$(document).ready loadOdometer
$(document).on "page:load", loadOdometer