import Foundation

struct WeatherDay {
    var avghumidity: Double
    var avgtempCelsius: Double

    init?(json: [String: Any]) {
        guard
            let avghumidity = json["avghumidity"] as? Double,
            let avgtempCelsius = json["avgtemp_c"] as? Double
        else {
            return nil
        }
        self.avghumidity = avghumidity
        self.avgtempCelsius = avgtempCelsius
    }
}
