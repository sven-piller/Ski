//
//  DataManager.swift
//  Ski
//
//  Created by LEOS Develop on 13.11.16.
//  Copyright © 2016 Sven Piller. All rights reserved.
//

import Foundation

enum DataManagerError: Error {
    case Unknown
    case FailedRequest
    case InvalidResponse
}

final class DataManager {

    typealias WeatherDataCompletion = (AnyObject?, DataManagerError?) -> ()

    let baseURL: URL

    // Init

    init(baseURL: URL){
        self.baseURL = baseURL
    }

    // Requesting Data

    func weatherDataForCity(cityName: String, completion: @escaping WeatherDataCompletion){
        var urlComponents = URLComponents.init(url: baseURL, resolvingAgainstBaseURL: false)
        let cityQuery = URLQueryItem(name: "q", value: cityName)
        urlComponents?.queryItems?.append(cityQuery)
        let URL = (urlComponents?.url)!
        // print(URL)

        URLSession.shared.dataTask(with: URL){ (data, response, error) in
            self.didFetchWeatherData(data: data, response: response, error:error, completion: completion)
        }.resume()
    }

    // Helper Methods
    private func didFetchWeatherData(data: Data?, response: URLResponse?, error: Error?, completion: WeatherDataCompletion) {
        if let _  = error {
            completion(nil, .FailedRequest)
        } else if let data = data, let response = response as? HTTPURLResponse {
            if response.statusCode == 200 {
                processWeatherData(data: data, completion: completion)
            } else {
                completion(nil, .FailedRequest)
            }
        } else {
            completion(nil, .Unknown)
        }

    }

    private func processWeatherData(data: Data, completion: WeatherDataCompletion){
        if let JSON = try? JSONSerialization.jsonObject(with: data, options: []) as AnyObject {
            completion(JSON, nil)
        } else {
            completion(nil, .InvalidResponse)
        }
    }

}
