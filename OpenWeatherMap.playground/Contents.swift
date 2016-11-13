//: Playground - noun: a place where people can play

import Foundation

// Fetch URL
let url = Bundle.main.url(forResource: "response", withExtension: "json")!

// Load Data
let data = try! Data(contentsOf: url)

// Deserialize JSON
let JSON = try! JSONSerialization.jsonObject(with: data, options: [])

if let weatherData = WeatherData(JSON: JSON) {
    print(weatherData)  
}

