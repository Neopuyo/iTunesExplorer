//
//  BlurModifier.swift
//  iTunesExplorer
//
//  Created by Loup Martineau on 19/01/2024.
//

import SwiftUI

/// No longer needed after iOS16.4+ with  presentationBackground(_:) modifier

///  from : https://medium.com/@edwurtle/blur-effect-inside-swiftui-a2e12e61e750
struct Blur: UIViewRepresentable {
	var style: UIBlurEffect.Style = .systemMaterial
	func makeUIView(context: Context) -> UIVisualEffectView {
		return UIVisualEffectView(effect: UIBlurEffect(style: style))
	}
	func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
		uiView.effect = UIBlurEffect(style: style)
	}
}

/// source : https://stackoverflow.com/questions/64301041/swiftui-translucent-background-for-fullscreencover
struct BackgroundBlurView: UIViewRepresentable {
	func makeUIView(context: Context) -> UIView {
		let view = UIVisualEffectView(effect: UIBlurEffect(style: .light))
		DispatchQueue.main.async {
			view.superview?.superview?.backgroundColor = .clear
		}
		return view
	}

	func updateUIView(_ uiView: UIView, context: Context) {}
}
