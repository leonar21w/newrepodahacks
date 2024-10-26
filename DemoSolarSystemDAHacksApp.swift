//
//  DemoSolarSystemDAHacksApp.swift
//  DemoSolarSystemDAHacks
//
//  Created by Leonard on 10/25/24.
//

import SwiftUI

@main
struct DemoSolarSystemDAHacksApp: App {
	
	@StateObject var envBackgronudScreen = HomeImage()
    var body: some Scene {
        WindowGroup {
            Homepage()
				.environmentObject(envBackgronudScreen)
        }
    }
}
