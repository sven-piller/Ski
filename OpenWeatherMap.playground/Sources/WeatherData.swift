import Foundation

public struct WeatherData {
    public let lat: Double
    public let lon: Double

    public let name: String
    public let wind: Double
    public let temp: Double

    public let short: String
    public let description: String
    public let icon: String

    public init(lat: Double, lon: Double, wind: Double, temp: Double, name: String, short: String, description: String, icon: String){
        self.lat = lat
        self.lon = lon
        self.wind = wind
        self.temp = temp
        self.name = name
        self.short = short
        self.description = description
        self.icon = icon
    }
}

extension WeatherData: JSONDecodable {
    public init(decoder: JSONDecoder) throws {
        self.lat = try decoder.decode(key: "coord.lat")
        self.lon = try decoder.decode(key: "coord.lon")
        self.wind = try decoder.decode(key: "wind.speed")
        self.temp = try decoder.decode(key: "main.temp")
        self.name = try decoder.decode(key: "name")
        self.short = ""
        self.description = ""
        self.icon = ""
    }


//    public init?(JSON: Any) {
//        guard let JSON = JSON as? [String: AnyObject] else { return nil }
//
//        guard let lat = JSON["coord"]?["lat"] as? Double else { return nil }
//        guard let lon = JSON["coord"]?["lon"] as? Double else { return nil }
//        guard let wind = JSON["wind"]?["speed"] as? Double else { return nil }
//        guard let temp = JSON["main"]?["temp"] as? Double else { return nil }
//        guard let name = JSON["name"] as? String else { return nil }
//        guard let short = (JSON["weather"] as? [[ String: AnyObject]])?[0]["main"] as? String else { return nil }
//        guard let description = (JSON["weather"] as? [[ String: AnyObject]])?[0]["description"] as? String else { return nil }
//        guard let icon = (JSON["weather"] as? [[ String: AnyObject]])?[0]["icon"] as? String else { return nil }
//
//        self.lat = lat
//        self.lon = lon
//        self.wind = wind
//        self.temp = temp - 273.15
//        self.name = name
//        self.short = short
//        self.description = description
//        self.icon = icon
//
//    }

}
