//
//  ListLoadingView.swift
//  iTunesExplorer
//
//  Created by Loup Martineau on 27/01/2024.
//

import SwiftUI

struct ListLoadingView: View {
	
	@State private var animateGradient = false
	
	var body: some View {
		// - TODO: animate text with moving gradient inside typo
		HStack(spacing: 20) {
			ProgressView()
				.progressViewStyle(CircularProgressViewStyle(tint: Color.complementary))
			Text("Exploring")
				.font(.largeTitle)
				.foregroundStyle(
					LinearGradient(
						colors: [.accentColor, .complementary, .complementary, .accentColor],
						startPoint: animateGradient ? .leading : .trailing,
						endPoint: animateGradient ? .trailing : .leading
					)
				)
		}
		.frame(maxHeight: .infinity, alignment: .center)
		.onAppear {
			withAnimation(.easeInOut(duration: 3).repeatForever(autoreverses: false)) {
				animateGradient.toggle()
			}
		}
		
	}
}

//#Preview {
//    ListLoadingView()
//}
