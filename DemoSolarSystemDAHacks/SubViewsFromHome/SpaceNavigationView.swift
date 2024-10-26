//
//  SpaceNavigationView.swift
//  DemoSolarSystemDAHacks
//
//  Created by Leonard on 10/26/24.
//

import SwiftUI

struct SpaceNavigationView: View {
	@State private var toggle1 = false
	@State private var toggle2 = false
	@State private var toggle3 = false

	var body: some View {
		ZStack {
			LoadBackground()
			anoyedCat()
				.offset(x: 100, y: 350)
			VStack {
				Text("A glance to our trip")
					.font(.title)
					.fontWeight(.bold)
					.foregroundStyle(Color.white.opacity(0.8))
					.padding(.horizontal, 35)
					.padding(.top, 50)
				Spacer()
			}
			Image("ArrowMoon")
				.resizable()
				.frame(width: 450, height: 450)
				.offset(y: 50)
			
			Image("ArrowMars")
				.resizable()
				.frame(width: 150, height: 450)
				.offset(x: -100, y: 45)
			
			PlanetSceneView(typeofView: "earthTexture", isZoomed: .constant(false))
				.frame(width: 450, height: 450)
				.clipShape(Circle())
				.offset(x: -100, y: 150)
				.onTapGesture {
					toggle1.toggle()
				}
		
			PlanetSceneView(typeofView: "MoonTexture", isZoomed: .constant(false))
				.frame(width: 350, height: 350)
				.clipShape(Circle())
				.offset(x: 100, y: -50)
				.onTapGesture {
					toggle2.toggle()
				}
		
			PlanetSceneView(typeofView: "marstexture", isZoomed: .constant(false))
				.frame(width: 350, height: 350)
				.clipShape(Circle())
				.offset(x: -100, y: -200)
				.onTapGesture {
					toggle3.toggle()
				}
			TransparentView()
				.offset(x: 20)
				
			.navigationBarHidden(true)
			.navigationDestination(isPresented: $toggle1) {
				EarthData()
			}
			.navigationDestination(isPresented: $toggle2) {
				MoonData()
			}
			.navigationDestination(isPresented: $toggle3) {
				MarsData()
			}
		}
	}
}

#Preview {
	SpaceNavigationView()
		.environmentObject(HomeImage())
}
