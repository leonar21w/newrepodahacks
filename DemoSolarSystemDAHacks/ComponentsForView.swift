//
//  ComponentsForView.swift
//  DemoSolarSystemDAHacks
//
//  Created by Leonard on 10/25/24.
//

import SwiftUI

struct TransparentView: View {
	// Environment variable to dismiss the view
	@Environment(\.presentationMode) var presentationMode

	var body: some View {
		ZStack {
			VStack(alignment: .leading){
				Button(action: {
					presentationMode.wrappedValue.dismiss()
				}) {
					Image(systemName: "arrow.left")
						.foregroundColor(.white)
						.padding()
						.padding(.trailing, 350)
				}
				Spacer()
			}
		}
	}
}

#Preview {
	TransparentView()
}
