//
//  Test.swift
//  DemoSolarSystemDAHacks
//
//  Created by Leonard on 10/25/24.
//

import SwiftUI

struct Test: View {
    var body: some View {
		Image("test")
			.resizable()

    }
}
struct cat: View {
	var body: some View {
		Image("HEHECAT")
			.resizable()
			.scaledToFit()
	}
}

struct anoyedCat: View {
	var body: some View {
		Image("annoyedCat")
			.resizable()
			.scaledToFit()
	}
}



#Preview {
	cat()
}
