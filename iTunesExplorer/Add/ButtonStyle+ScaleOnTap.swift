//
//  Button+ScaleOnTap.swift
//  iTunesExplorer
//
//  Created by Loup Martineau on 26/01/2024.
//

import SwiftUI

struct ScaleOnTap: ButtonStyle {
	func makeBody(configuration: Self.Configuration) -> some View {
		configuration.label
			.font(.headline)
			.padding(8)
			.background(Color.accentColor)
			.clipShape(Capsule())
			.foregroundColor(.secondary)
			.scaleEffect(configuration.isPressed ? 1.2 : 1, anchor: .center)
	}
}
