//
//  ChooseSpaceObjectView.swift
//  DemoSolarSystemDAHacks
//
//  Created by Leonard on 10/25/24.
//

import SwiftUI

struct ChooseSpaceObjectView: View {
    var body: some View {
		ZStack {
			LoadBackground()
			TransparentView()
			anoyedCat()
				.offset(x: 100, y: 350)
			VStack{
				HStack {
					Text("A glance to our trip")
						.font(.title)
						.fontWeight(.bold)
						.foregroundStyle(Color.white.opacity(0.8))
						.padding(.horizontal, 35)
					
				}
				VStack (alignment: .leading){
					HStack {
						NavigationLink(destination: EarthData()) {
							BoxForChoosingPlanetView(celestialObject: "Earth", typeOfView: "earthTexture")
						}
						NavigationLink(destination: MoonData()) {
							BoxForChoosingPlanetView(celestialObject: "Moon", typeOfView: "MoonTexture")
						}
						
					}
					HStack {
						NavigationLink(destination: MarsData()) {
							BoxForChoosingPlanetView(celestialObject: "Mars", typeOfView: "marstexture")
							
						}
						
					}
				}.padding(.horizontal, 35)
					.padding(.leading, 10)

			}
			Spacer()
			.navigationBarHidden(true)
		}
    }
}

#Preview {
    ChooseSpaceObjectView()
}
