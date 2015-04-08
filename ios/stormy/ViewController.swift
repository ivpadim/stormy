//
//  ViewController.swift
//  stormy
//
//  Created by ivpadim on 4/7/15.
//  Copyright (c) 2015 ivpadim. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var humidityValue: UILabel!
    @IBOutlet weak var precipValue: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var refreshActivityIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        refreshActivityIndicator.hidden = true
        
        let latitude = 25.7260132
        let longitude = -100.3456458
        
        getForecast(latitude, longitude:longitude)
        
    }

    func toggleRefresh(){
        if(refreshActivityIndicator.hidden == true){
            refreshActivityIndicator.hidden = false
            refreshActivityIndicator.startAnimating()
            refreshButton.hidden = true
        }
        else{
            refreshActivityIndicator.hidden = true
            refreshActivityIndicator.stopAnimating()
            refreshButton.hidden = false
        }
    }
    
    func getForecast(latitude:Double, longitude:Double) {
        
        toggleRefresh()
        
        let apiKey = "97b0fb56ec9a1061cb90aae83f25de3f"
        
        let forecastUrl = NSURL(string:"https://api.forecast.io/forecast/\(apiKey)/\(latitude),\(longitude)?units=si")
        
        let sharedSession = NSURLSession.sharedSession()
        let downloadTask = sharedSession.downloadTaskWithURL(
            forecastUrl!,
            completionHandler: { (location:NSURL!, response:NSURLResponse!, error:NSError!) -> Void in
                
                //var contents = NSString(contentsOfURL: location!, encoding: NSUTF8StringEncoding, error: nil)
                //println(contents)
                dispatch_async(dispatch_get_main_queue(), {() -> Void in self.toggleRefresh() })
                
                if(error == nil) {
                    
                    let dataObject = NSData(contentsOfURL: location)
                    let weatherDictionary : NSDictionary = NSJSONSerialization
                        .JSONObjectWithData(dataObject!, options: nil, error: nil) as NSDictionary
                    
                    let currentWeather = CurrentWeather( weatherDictionary:  weatherDictionary)
                    
                    
                    dispatch_async(dispatch_get_main_queue(), {() -> Void in
                        self.temperatureLabel.text  = "\(currentWeather.temperature)"
                        self.timeLabel.text = "At \(currentWeather.getFormattedTime()) it will be"
                        self.humidityValue.text = "\(currentWeather.humidity)"
                        self.precipValue.text = "\(currentWeather.getPrecipitate()) %"
                        self.summaryLabel.text = currentWeather.summary
                        self.iconImageView.image = currentWeather.getIconImage()!
                    })
                    
                    
                }
                else{
                    println(error)
                    let networkIssueController = UIAlertController(title: "Oops! Sorry!", message: "There was an error. Please try again.", preferredStyle: .Alert)
                    
                    let okButton = UIAlertAction(title: "OK", style: .Default, handler: nil)
                    
                    networkIssueController.addAction(okButton)
                    
                    self.presentViewController(networkIssueController, animated: true, completion: nil)
                }
                
                
                
        })
        
        downloadTask.resume()
    }
    
    @IBAction func refresh() {
        let latitude = 25.7260132
        let longitude = -100.3456458
        
        getForecast(latitude, longitude:longitude)

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

