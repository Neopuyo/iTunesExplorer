//
//  ListNotSearchedYetView.swift
//  iTunesExplorer
//
//  Created by Loup Martineau on 27/01/2024.
//

import SwiftUI

struct ListNotSearchedYetView: View {
	
	@State private var rotation = -7.5
	let onTapCompletion: () -> ()
	
	var body: some View {
		// - TODO: welcome user with picture&Text, button to focus on textField + logoapp icon
		VStack {
		
			Circle()
				.fill(Color.accentColor)
				.frame(width: 100, height: 100)
				.overlay {
					Circle()
						.stroke(lineWidth: 8.0)
						.fill(Color.gradientEnd)
				}
				.overlay {
					Button {
						onTapCompletion()
					} label: {
						Image(systemName: "star.fill")
							.resizable()
							.scaledToFit()
							.foregroundStyle(Color.complementary)
							.frame(width: 120, height: 120)
							.rotationEffect(Angle(degrees: rotation))
							.animation(
								.linear(duration: 1.2)
								.repeatForever(autoreverses: true),
								value: rotation)
					}
					.buttonStyle(ScaleOnTap(capsuled: false))
				}
			
		}
		.frame(maxHeight: .infinity, alignment: .center)
		.onAppear {
			rotation = 7.5
		}
    }
}

//#Preview {
//    ListNotSearchedYetView()
//}
