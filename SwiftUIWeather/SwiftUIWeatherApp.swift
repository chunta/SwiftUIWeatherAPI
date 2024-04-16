import SwiftUI

@main
struct SwiftUIWeatherApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(weatherViewModel: FamousCityWeatherViewModel())
        }
    }
}
