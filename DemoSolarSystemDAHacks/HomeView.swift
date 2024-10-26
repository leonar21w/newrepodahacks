//
//  ContentView.swift
//  DemoSolarSystemDAHacks
//
//  Created by Leonard on 10/25/24.
//

import SwiftUI

	
struct Homepage: View {
	@EnvironmentObject var homeBackground: HomeImage
	
	
	
	var body: some View {
		NavigationStack {
			ZStack {
				LoadBackground()
				Test()
					.scaledToFit()
				VStack {
					Text("Traveling in Space?")
						.font(.title)
						.fontWeight(.bold)
						.foregroundColor(.white.opacity(0.8))
						.padding(.bottom, 20)
					
					NavigationLink(destination: SpaceNavigationView()) {
						Text("Check for destinations in space")
							.font(.headline)
							.fontWeight(.semibold)
							.foregroundColor(.white.opacity(0.8))
							.padding()
							.background(RoundedRectangle(cornerRadius: 20).fill(Color.gray.opacity(0.4)))
							.cornerRadius(8)
						
						
					}
					
					Spacer()
					
					
					Text("Credits: \(homeBackground.changed ? homeBackground.homepageImageData.copyright : "Massimo Di Fusco")")
						.font(.headline)
						.fontWeight(.semibold)
						.foregroundColor(.white.opacity(0.3))
					
					Text(" Title: \(homeBackground.changed ? homeBackground.homepageImageData.title : "Globular Star Cluster NGC 6752")")
						.font(.headline)
						.fontWeight(.semibold)
						.foregroundColor(.white.opacity(0.3))
				}
				.transition(.opacity)
				.animation(.easeInOut(duration: 0.5), value: homeBackground.changed)
				.padding()
			}
		}
	}
}

#Preview {
	Homepage()
}
