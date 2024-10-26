//
//  days.swift
//  DemoSolarSystemDAHacks
//
//  Created by Leonard on 10/26/24.
//

import Foundation

func getDate() -> String {
	let dateFormatter = DateFormatter()
	dateFormatter.dateFormat = "yyyy-MM-dd"
	
	return dateFormatter.string(from: Date())
}

func getDateminusone() -> String {
	let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())
	
	let dateFormatter = DateFormatter()
	dateFormatter.dateFormat = "yyyy-MM-dd"
	return dateFormatter.string(from: yesterday ?? Date())
}
