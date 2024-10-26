//
//  MarsData.swift
//  DemoSolarSystemDAHacks
//
//  Created by Leonard on 10/25/24.
//

import SwiftUI

struct MarsData: View {
	
	@StateObject var horizonvm = EarthMarsDistanceFetcher()
	@StateObject var tempmars = theresbullisinmyveinsnowMARS()
	
	@State private var isVisible = false
	@State private var isZoomed1 = false
	@State private var isZoomed2 = false
	
	var body: some View {
		ZStack {
			LoadBackground()
			
			ZStack{
				Text("\(getDate())")
					.font(.subheadline)
					.fontWeight(.semibold)
					.foregroundStyle(Color.white)
			}
			.offset(x: -90 , y: -5)
			
			ZStack{
				Text("\(getDateminusone())")
					.font(.subheadline)
					.fontWeight(.semibold)
					.foregroundStyle(Color.white)
			}
			.offset(x: -90 , y: -135)
			
			ZStack {
				PlanetSceneView(typeofView: "earthTexture", isZoomed: $isZoomed1)
					.frame(width: 700 , height: 700)
					.clipShape(Circle())
					.offset(x: 150,y: -250)
					.onLongPressGesture(minimumDuration: 0.1, maximumDistance: 50, pressing: { pressing in
						withAnimation {
							isZoomed1 = pressing
						}
					}) {}
				
				cat()
					.offset(x: 130, y: 350)
				PlanetSceneView(typeofView: "marstexture", isZoomed: $isZoomed2)
					.frame(width: 700 , height: 700)
					.clipShape(Circle())
					.offset(x: -150,y: 250)
					.onLongPressGesture(minimumDuration: 0.1, maximumDistance: 50, pressing: { pressing in
						withAnimation {
							isZoomed2 = pressing
						}
					}) {}
			}
			TransparentView()
			
			VStack{
				Text("Time to get there?")
					.font(.title)
					.fontWeight(.bold)
					.foregroundStyle(Color.white)
				
				ForEach(horizonvm.platypuswearinghat(), id: \.0) { data in
					VStack(alignment: .leading){
						Text("Distance")
							.font(.subheadline)
							.fontWeight(.semibold)
							.foregroundStyle(Color.white)
						Text("\(data.0) km from Earth")
							.foregroundStyle(Color.white)
						Text("Getting there in..")
							.font(.subheadline)
							.fontWeight(.semibold)
							.foregroundStyle(Color.white)
						Text("\(data.1) days and \(data.2) hours")
							.foregroundStyle(Color.white)
					}
					.padding()
					Divider()
						.foregroundStyle(Color.white)
				}
				
				//CHANGE THIS WITH DATA
				VStack(alignment: .center){
					Text("! BEWARE !")
						.font(.subheadline)
						.fontWeight(.semibold)
						.foregroundStyle(Color.white)
					Text("Just remember that temperature easily plummets")
						.font(.caption)
						.fontWeight(.light)
						.foregroundStyle(Color.white)
					Text("Temperatures can get as high as to \(Int(tempmars.marsTemp.temperature.max))°C")
							.font(.caption)
							.fontWeight(.light)
							.foregroundStyle(Color.white)
					Text("Temperatures can go down to \(Int(tempmars.marsTemp.temperature.min))°C")
						.font(.caption)
						.fontWeight(.light)
						.foregroundStyle(Color.white)
				}
				
			}
			.opacity(isVisible ? 1 : 0)
			.animation(.easeIn(duration: 1.5), value: isVisible)
		}.navigationBarHidden(true)
			.onAppear {
				isVisible = true
			}
	}
}

#Preview {
	MarsData()
		.environmentObject(HomeImage())
}
