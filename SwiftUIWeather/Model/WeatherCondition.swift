import Foundation

struct WeatherCondition: Codable, Identifiable {
    var id: UUID?
    var date: String
    var humidity: Double
    var tempCelsius: Double
    init(date: String, humidity: Double, tempCelsius: Double) {
        self.id = UUID()
        self.date = date
        self.humidity = humidity
        self.tempCelsius = tempCelsius
    }
}
