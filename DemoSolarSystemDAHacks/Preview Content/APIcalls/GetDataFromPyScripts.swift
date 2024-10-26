//
//  GetDataFromPyScripts.swift
//  DemoSolarSystemDAHacks
//
//  Created by Leonard on 10/25/24.
//

import Foundation

@MainActor
class theresbullisinmyveinsnowMARS: ObservableObject {
	
	@Published var marsTemp: emptyRedBullCan = emptyRedBullCan(sol: 0,
															   temperature: anotherEmptyRedBullCan(
																average: 0.0, max: 0.0, min: 0.0))
	
	init() {
		Task {
			do {
				self.marsTemp = try await getTheRedBullCans()
			} catch {
				throw URLError(.badURL)
			}
		}
	}
	
	
	func getTheRedBullCans() async throws -> emptyRedBullCan {
		let jsonDecoder = JSONDecoder()
		jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
		
		guard let url = URL(string: "https://backend-for-frontend.onrender.com/mars_data") else {
			throw URLError(.badURL)
		}
		
		let (data, response) = try await URLSession.shared.data(for: URLRequest(url: url))
		print(data)
		
		guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
			throw URLError(.badServerResponse)
		}
		
		return try jsonDecoder.decode(emptyRedBullCan.self, from: data)
	}
	
	
	
	
}


struct emptyRedBullCan: Codable {
	let sol: Int
	let temperature: anotherEmptyRedBullCan
	
}

struct anotherEmptyRedBullCan: Codable {
	let average: Double
	let max: Double
	let min: Double
}

