import Foundation

class FamousCityWeatherViewModel: CityWeatherViewModel {
    private let apiKey = "96d64ec5a2ec46d99bd71813241602"

    override func fetchCity(city: Cities) {
        guard let url = makeURL(for: city) else { return }
        self.loading = true
        let request = URLRequest(url: url)
        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.loading = false
                if let error = error {
                    self.handleError(message: error.localizedDescription)
                    return
                }
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    self.handleError(message: "Invalid response")
                    return
                }
                guard let jsonData = data else {
                    self.handleError(message: "No data received")
                    return
                }
                self.parseJSONData(jsonData, for: city)
            }
        }.resume()
    }

    private func makeURL(for city: Cities) -> URL? {
        let urlString = "http://api.weatherapi.com/v1/forecast.json?key=\(apiKey)&q=\(city.rawValue)&days=7&aqi=no&alerts=no"
        return URL(string: urlString)
    }

    private func parseJSONData(_ data: Data, for city: Cities) {
        do {
            guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                  let forecast = json["forecast"] as? [String: Any],
                  let forecastday = forecast["forecastday"] as? [[String: Any]] else {
                print("Failed to extract forecast data for \(city.rawValue)")
                return
            }

            let weatherConditions = forecastday.compactMap { dayData -> WeatherCondition? in
                guard
                    let date = dayData["date"] as? String,
                    let day = dayData["day"] as? [String: Any],
                    let weatherDay = WeatherDay(json: day)
                else {
                    print("Failed to parse WeatherDay data")
                    return nil
                }
                return WeatherCondition(date: date,
                                        humidity: weatherDay.avghumidity,
                                        tempCelsius: weatherDay.avgtempCelsius)
            }
            self.cityWeatherTable[city] = weatherConditions
        } catch {
            print("Error parsing JSON data:", error)
        }
    }

    private func handleError(message: String) {
        self.errorMessage = message
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.errorMessage = ""
        }
    }
}
