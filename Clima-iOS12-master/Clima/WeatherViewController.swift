//
//  ViewController.swift
//  WeatherApp
//
//  Created by Angela Yu on 23/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON



class WeatherViewController: UIViewController, CLLocationManagerDelegate, Changecitydelegate {
    
    //Constants
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "e0a9eb5122b891c7089b9262a59728c0"
    /***Get your own App ID at https://openweathermap.org/appid ****/
    

    //TODO: Declare instance variables here
    let locationManager = CLLocationManager()
    let Weatherdatamodel = WeatherDataModel()

    
    //Pre-linked IBOutlets
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //TODO:Set up the location manager here.
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        
    }
    
    
    
    //MARK: - Networking
    /***************************************************************/
    
    //Write the getWeatherData method here:
    func getWeatherData(URL : String, parameters : [String : String])
    {
        Alamofire.request(URL,method: .get, parameters : parameters).responseJSON {
            response in
            if(response.result.isSuccess)
            {
                print("Success! Got the weather data")
                let weatherJSON : JSON = JSON(response.result.value!)
                
                print(weatherJSON)
                self.updateWeatherData(json : weatherJSON)
                
            }
            else{
                print("Error")
                
                self.cityLabel.text = "Connection issues"
            }
        }
        
    }

    
    
    
    
    
    //MARK: - JSON Parsing
    /***************************************************************/
   
    
    //Write the updateWeatherData method here:
    func updateWeatherData(json : JSON)
    {
        if let tempResult = json["main"]["temp"].double
        {
            
            Weatherdatamodel.temperature = Int(tempResult - 273.15)
            
            Weatherdatamodel.city = json["name"].stringValue
            
            Weatherdatamodel.condition = json["weather"][0]["id"].intValue
            
            Weatherdatamodel.WeatherIconName = Weatherdatamodel.updateWeatherIcon(condition : Weatherdatamodel.condition)
            
            updateUIwithweatherdata()
            }
        else{
            print("HIIIIII")
        }
        
    }

    
    
    
    //MARK: - UI Updates
    /***************************************************************/
    
    
    //Write the updateUIWithWeatherData method here:
    func updateUIwithweatherdata()
    {
        cityLabel.text = Weatherdatamodel.city
        temperatureLabel.text = "\(Weatherdatamodel.temperature)"
        weatherIcon.image = UIImage(named: Weatherdatamodel.WeatherIconName)
    }
    
    
    
    
    
    //MARK: - Location Manager Delegate Methods
    /***************************************************************/
    
    
    //Write the didUpdateLocations method here:
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0
        {
            locationManager.stopUpdatingLocation()
        }
        print("longitude = \(location.coordinate.longitude), latitude = \(location.coordinate.latitude)")
        
        let latitude = String(location.coordinate.latitude)
        let longitude = String(location.coordinate.longitude)
        let params : [String : String] = ["lat" : latitude, "lon" : longitude, "appid" : APP_ID]
        
        getWeatherData(URL : WEATHER_URL, parameters : params)
    }
    
    
    
    //Write the didFailWithError method here:
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        cityLabel.text = "Location Unavailable"
    }

    
    

    
    //MARK: - Change City Delegate methods
    /***************************************************************/
    
    
    //Write the userEnteredANewCityName Delegate method here:
    func userenterednewcityname(city: String) {
        let params : [String : String] = ["q" : city, "appid" : APP_ID]
        getWeatherData(URL: WEATHER_URL, parameters: params)
    }

    
    //Write the PrepareForSegue Method here
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "changeCityName")
        {
            let destinationVC = segue.destination as! ChangeCityViewController
            
            destinationVC.delegate = self
        }
    }
    
    
    
}


