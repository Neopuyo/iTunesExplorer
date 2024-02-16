//
//  ListNotSearchedYetView.swift
//  iTunesExplorer
//
//  Created by Loup Martineau on 27/01/2024.
//

import SwiftUI

struct ListNotSearchedYetView: View {
	
	@State private var rotation = -7.5
	
	let starText: String?
	let onTapCompletion: () -> ()
	
	var body: some View {
		VStack {
			Text(starText ?? "")
				.font(.title)
				.foregroundStyle(Color.whiteLock)
				.transaction { transaction in
					transaction.animation = .snappy(extraBounce: 0.2)
				}
			Circle()
				.fill(Color.whiteLock.opacity(0.1))
				.frame(width: 160, height: 160)
				.overlay {
					Circle()
						.stroke(lineWidth: 1.0)
						.fill(Color.whiteLock.opacity(0.2))
				}
				.overlay {
					Button {
						onTapCompletion()
					} label: {
						
						exploStarAsPngIconView
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
	
	// - TODO: build it as swiftUI shape instead of usign a png
	@ViewBuilder
	private var exploStarAsPngIconView: some View {
		ZStack {
			Image("explorerStar")
				.resizable()
				.scaledToFit()
		}
	}
	
}
