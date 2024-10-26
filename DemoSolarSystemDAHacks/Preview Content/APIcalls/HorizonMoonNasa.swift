//
//  HorizonNasaAPI.swift
//  DemoSolarSystemDAHacks
//
//  Created by Leonard on 10/26/24.
//

import Foundation


@MainActor
class EarthMoonDistanceFetcher: ObservableObject {
	
	private let baseURL = "https://ssd.jpl.nasa.gov/api/horizons.api"
	
	@Published var moonDistanceData = DistAndEpArr(distances: [])
	
	init() {
		appendEarthMoonDistance()
		//when we initialize this class just get the data already
		//The onappear will return the beaver so that beaver can populate the array of tuples
	}
	
	func calculateTravelTimes(distanceKm: Double) -> (String, String) {
		let averageSpeedKmPerHour = 5000.0  // Average speed, e.g., Apollo missions
		
		let timeHours = distanceKm / averageSpeedKmPerHour
		
		let timeDays = Int(timeHours / 24)
		let remainingHours = (timeHours * 100).rounded() / 100
		
		return (String(timeDays), String(Int(ceil(remainingHours))))
	}
	
	func beaverwearinghat() -> [(Double, String, String)] {
			var results: [(Double, String, String)] = []
			
			for distance in moonDistanceData.distances {
				let travelTime = calculateTravelTimes(distanceKm: distance)
				results.append((distance, travelTime.0, travelTime.1)) //0 is days //1 is remain hours
			}
			return results
		}
	
	
	func fetchEarthMoonDistance(completion: @escaping (Result<String, Error>) -> Void) {
		let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())
		
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd"
		
		
		let parameters: [String: String] = [
			"format": "json",
			"COMMAND": "301", //Moon code
			"EPHEM_TYPE": "OBSERVER",
			"CENTER": "500@399",
			"START_TIME": dateFormatter.string(from: yesterday ?? Date()),
			"STOP_TIME": dateFormatter.string(from: Date()),
			"STEP_SIZE": "1d",
			"QUANTITIES": "20"
		]
		
		var urlComponents = URLComponents(string: baseURL)!
		urlComponents.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value) }
		
		guard let url = urlComponents.url else {
			print("Invalid URL")
			return
		}
		
		let task = URLSession.shared.dataTask(with: url) { data, response, error in
			if let error = error {
				completion(.failure(error))
				return
			}
			
			guard let data = data else {
				let noDataError = NSError(domain: "EarthMoonDistanceFetcher", code: 1, userInfo: [NSLocalizedDescriptionKey: "No data received"])
				completion(.failure(noDataError))
				return
			}
			
			//Horizon has crazy looking data formatting so fingers crossed
			do {
				if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
					if let result = jsonResponse["result"] as? String {
						completion(.success(result))
					} else {
						let parseError = NSError(domain: "EarthMoonDistanceFetcher", code: 2, userInfo: [NSLocalizedDescriptionKey: "Unable to find distance data in JSON"])
						completion(.failure(parseError))
					}
				}
			} catch {
				completion(.failure(error))
			}
		}
		
		task.resume()
	}
	
	func appendEarthMoonDistance() {
		fetchEarthMoonDistance { result in
			switch result {
				case .success(let dataString):
					print("Raw Distance Data:\n\(dataString)")
					
					let auToKm = 149_597_870.7 // 1 AU in kilometers
					let lines = dataString.split(separator: "\n")
					var isEphemerisData = false
					
					for line in lines {
						if line.contains("$$SOE") {
							isEphemerisData = true
							continue
						}
						
						if line.contains("$$EOE") {
							isEphemerisData = false
							break
						}
						
						if isEphemerisData {
							let dataFields = line.split(separator: " ")
							if dataFields.count >= 3, let auValue = Double(dataFields[2]) {
								let distanceKm = auValue * auToKm
								let roundedDistance = (distanceKm * 100).rounded() / 100
								DispatchQueue.main.async {
									self.moonDistanceData.distances.append(roundedDistance)
								}
							}
						}
					}
					
				case .failure(let error):
					print("Failed to fetch distance data: \(error.localizedDescription)")
			}
		}
	}
}


struct DistAndEpArr {
	var distances: [Double] = []
}


