//
//  CurrentWeather.swift
//  stormy
//
//  Created by ivpadim on 4/7/15.
//  Copyright (c) 2015 ivpadim. All rights reserved.
//

import Foundation
import UIKit

struct CurrentWeather{
    var time : Int //?
    var temperature : Int
    var humidity : Double
    var precipitate : Double
    var summary : String
    var icon : String
    
    init(weatherDictionary : NSDictionary){
        /*time = 1
        temperature = 10
        humidity = 0.0
        precipitate = 0.0
        summary = "no-summary"
        icon = "no-icon"*/
        let currentWeather  = weatherDictionary["currently"] as NSDictionary
        
        humidity = currentWeather["humidity"] as Double
        time = currentWeather["time"] as Int
        icon = currentWeather["icon"] as String;
        precipitate = currentWeather["precipProbability"] as Double
        summary = currentWeather["summary"] as String
        temperature = currentWeather["temperature"] as Int
    }
    
    func getFormattedTime() -> NSString {
        let timeInSeconds = NSTimeInterval(time)
        let date = NSDate(timeIntervalSince1970: timeInSeconds)
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeStyle = .ShortStyle
        
        return dateFormatter.stringFromDate(date)
    }
    
    func getPrecipitate() -> Int {
        return Int(precipitate * 100)
    }
    
    func getIconImage() -> UIImage? {
        var iconImage : String
        
        switch icon
        {
        case "clear-day":
            iconImage = "clear-day"
        case "clear-night":
            iconImage="clear-night"
        case "rain":
            iconImage="rain"
        case "snow":
            iconImage="snow"
        case "sleet":
            iconImage="sleet"
        case "wind":
            iconImage="wind"
        case "fog":
            iconImage="fog"
        case "cloudy":
            iconImage="cloudy"
        case "partly-cloudy-day":
            iconImage="partly-cloudy"
        case "partly-cloudy-night":
            iconImage="cloudy-night"
        default:
            iconImage="default"
        }
        
        var image = UIImage(named: iconImage)
        
        return image
    }
}

