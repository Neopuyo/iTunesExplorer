//
//  ContentView.swift
//  iTunesExplorer
//
//  Created by Loup Martineau on 15/01/2024.
//

import SwiftUI

struct ContentView: View {
	@State private var input:String = ""
	
    var body: some View {
        VStack {
			HStack {
				Image(systemName: "magnifyingglass.circle.fill")
				TextField("Music, app, e-book...", text: $input)
			}
			Spacer()
        }
        .padding()
    }
}

//#Preview {
//    ContentView()
//}
