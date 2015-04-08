// Playground - noun: a place where people can play

import UIKit

let apiKey = "97b0fb56ec9a1061cb90aae83f25de3f"

let latitude = 25.7260132
let longitude = -100.3456458

let forecastUrl = NSURL(string:"https://api.forecast.io/forecast/\(apiKey)/\(latitude),\(longitude)?units=si")

let weatherData = NSData(contentsOfURL: forecastUrl!, options:nil, error:nil)

println(weatherData)
