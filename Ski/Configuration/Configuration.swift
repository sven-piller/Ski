//
//  Configuration.swift
//  Ski
//
//  Created by LEOS Develop on 13.11.16.
//  Copyright © 2016 Sven Piller. All rights reserved.
//

import Foundation

struct OpenWeatherMapAPI {
    static let APIKey = "157135a9a3261431fb3a536692456324"

    static let scheme = "http";
    static let host = "api.openweathermap.org";
    static let path = "/data/2.5/weather";

    static var AuthenticatedBaseURL: URL {
        // create "http://api.openweathermap.org/data/2.5/weather" URL using urlComponents
        var urlComponents = URLComponents()
        urlComponents.scheme = scheme
        urlComponents.host = host
        urlComponents.path = path

        // add params
        let langQuery = URLQueryItem(name: "lang", value: Defaults.Language)
        let apikeyQuery = URLQueryItem(name: "APPID", value: APIKey)
        urlComponents.queryItems = [langQuery, apikeyQuery]

        return urlComponents.url!
    }
}

struct Defaults {
    static let City: String = "Scheffau"
    static let Language: String = "de"
}
