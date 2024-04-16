import SwiftUI

struct ContentView: View {
    @ObservedObject var weatherViewModel: CityWeatherViewModel
    @State private var selectedIndex = 0
    @State private var title = "--"

    var body: some View {
        ZStack {
            VStack {
                Label(
                    title: { Text(title) },
                    icon: { }
                )
                TabView(selection: $selectedIndex) {
                    tokyoTab
                        .tabItem {
                            Label("Tokyo", systemImage: "heart.fill")
                        }
                        .tag(0)
                    newYorkTab
                        .tabItem {
                            Label("New York", systemImage: "square.fill")
                        }
                        .tag(1)
                    berlinTab
                        .tabItem {
                            Label("Berlin", systemImage: "capsule.fill")
                        }
                        .tag(2)
                }
                .onChange(of: selectedIndex) { index in
                    selectedIndex = index
                }
            }
            if weatherViewModel.loading {
                ProgressView()
            }
        }
    }

    private var tokyoTab: some View {
        NavigationView {
            List {
                ForEach(weatherViewModel.cityWeatherTable[.Tokyo] ?? [], id: \.id) { weatherCondition in
                    HStack {
                        Text(weatherCondition.date)
                        Text("\(weatherCondition.humidity)")
                        Text("\(weatherCondition.tempCelsius)")
                    }
                }
            }
        }
        .onAppear {
            title = "Tokyo"
            weatherViewModel.fetchCity(city: .Tokyo)
        }
    }

    private var newYorkTab: some View {
        NavigationView {
            List {
                ForEach(weatherViewModel.cityWeatherTable[.NewYork] ?? [], id: \.id) { weatherCondition in
                    HStack {
                        Text(weatherCondition.date)
                        Text("\(weatherCondition.humidity)")
                        Text("\(weatherCondition.tempCelsius)")
                    }
                }
            }
        }
        .onAppear {
            title = "New York"
            weatherViewModel.fetchCity(city: .NewYork)
        }
    }

    private var berlinTab: some View {
        NavigationView {
            List {
                ForEach(weatherViewModel.cityWeatherTable[.Berlin] ?? [], id: \.id) { weatherCondition in
                    HStack {
                        Text(weatherCondition.date)
                        Text("\(weatherCondition.humidity)")
                        Text("\(weatherCondition.tempCelsius)")
                    }
                }
            }
        }
        .navigationTitle("Berlin")
        .onAppear {
            title = "Berlin"
            weatherViewModel.fetchCity(city: .Berlin)
        }
    }
}

#Preview {
    ContentView(weatherViewModel: FamousCityWeatherViewModel())
}
