//
//  View+hideKeyboard.swift
//  iTunesExplorer
//
//  Created by Loup Martineau on 11/02/2024.
//

import SwiftUI

#if canImport(UIKit)
extension View {
	func hideKeyboard() {
		UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
	}
}
#endif
