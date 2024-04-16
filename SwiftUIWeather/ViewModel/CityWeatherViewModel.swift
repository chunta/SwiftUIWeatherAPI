import Foundation

class CityWeatherViewModel: ObservableObject {
    @Published var cityWeatherTable: [Cities: [WeatherCondition]] = [:]
    @Published var loading = false
    @Published var errorMessage = ""
    func fetchCity(city: Cities) {}
}
