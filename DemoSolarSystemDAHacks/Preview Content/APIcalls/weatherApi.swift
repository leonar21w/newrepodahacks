//
//  weatherApi.swift
//  DemoSolarSystemDAHacks
//
//  Created by Leonard on 10/25/24.
//

import Foundation

@MainActor
class WeatherViewVM: ObservableObject {
	
	@Published var data: weatherData = weatherData(address: "LOADING", currentConditions:
													PLEASEHELPME(datetime: "",
																 temp: 0.0,
																 feelslike: 0.0,
																 humidity: 0.0,
																 conditions: "",
																 icon: ""))
	init() {
		Task {
			self.data = try await getEarth()
		}
	}
	
	func getEarth() async throws -> weatherData {
		let jsonDecoder = JSONDecoder()
		jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
		
		guard let url = URL(string:
								"https://weather.visualcrossing.com/VisualCrossingWebServices/rest/services/timeline/Cupertino?unitGroup=metric&include=current&key=\(weatherEarth)&contentType=json"
) else {
			throw URLError(.badURL)
		}
		
		let (data, response) = try await URLSession.shared.data(for: URLRequest(url: url))
		
		guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
			throw URLError(.badServerResponse)
		}
		return try jsonDecoder.decode(weatherData.self, from: data)
	}
	
}

struct weatherData: Codable {
	let address: String
	let currentConditions: PLEASEHELPME
	
}
struct PLEASEHELPME: Codable {
	let datetime: String
	let temp: Double
	let feelslike: Double
	let humidity: Double
	let conditions: String
	let icon: String
}
