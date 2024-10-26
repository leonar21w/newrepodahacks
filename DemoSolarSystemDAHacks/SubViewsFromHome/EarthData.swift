//
//  EarthData.swift
//  DemoSolarSystemDAHacks
//
//  Created by Leonard on 10/25/24.
//

import SwiftUI

struct EarthData: View {
	
	@StateObject var vm = WeatherViewVM()
	@State private var isZoomed = false
	
	var body: some View {
		ZStack {
			LoadBackground()
			TransparentView()
			VStack {
				PlanetSceneView(typeofView: "earthTexture", isZoomed: $isZoomed)
					.frame(width: 350 , height: 350)
					.clipShape(Circle())
					.offset(y: -130)
					.onLongPressGesture(minimumDuration: 0.1, maximumDistance: 50, pressing: { pressing in
						withAnimation {
							isZoomed = pressing
						}
					}) {}
					
			}
			
			VStack(alignment: .center){
				Text(vm.data.address)
					.font(.title)
					.fontWeight(.semibold)
					.foregroundStyle(Color.white)
				Text("\(Int(ceil(vm.data.currentConditions.feelslike)))°")
					.font(.system(size: 80))
					.fontWeight(.regular)
					.foregroundStyle(Color.white)
				Text("\(vm.data.currentConditions.conditions)")
					.font(.title)
					.fontWeight(.medium)
					.foregroundStyle(Color.white)
				
				HStack{
					Text("Humidity")
						.font(.subheadline)	.fontWeight(.medium)
						.foregroundStyle(Color.white)
					
					
					Text("\(vm.data.currentConditions.humidity)")
						.font(.subheadline)
						.fontWeight(.medium)
						.foregroundStyle(Color.white)
					
				}
				
				
			}
		}.navigationBarHidden(true)
	}
}

#Preview {
    EarthData()
		.environmentObject(HomeImage())
}
