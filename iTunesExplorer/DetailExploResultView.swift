//
//  DetailExploResultView.swift
//  iTunesExplorer
//
//  Created by Loup Martineau on 19/01/2024.
//

import SwiftUI
import Neopuyo

struct DetailExploResultView: View {
	@Environment(\.dismiss) private var dismiss
	let exploResult: ExploResult
	let geo: GeometryProxy
	
	
	var body: some View {
		VStack(alignment: .center) {
			Button {
				dismiss()
			} label: {
				Image(systemName: "x.circle.fill")
			}
			AsyncImage(url: URL(string: exploResult.imageLarge))
			Text(exploResult.name)
			Text(exploResult.artistName ?? "unknown")
			Text("Type : \(exploResult.type)")
			Text("Genre : \(exploResult.genre)")
			Button {
				dismiss()
			} label: {
				Text(getPrice())
			}
		}
		.frame(width: geo.size.width * 0.65, height: geo.size.height * 0.80)
		.padding()
		.background(.ultraThinMaterial)
		.cornerRadius(16)
	}
	
	private func getPrice() -> String {
		let formatter = NumberFormatter()
		formatter.numberStyle = .currency
		formatter.currencyCode = exploResult.currency
		
		let priceText: String
		if exploResult.price == 0 {
			priceText = "Free"
		} else if let text = formatter.string(from: exploResult.price as NSNumber) {
			priceText = text
		} else {
			priceText = ""
		}
		return priceText
	}
}

//#Preview {
//    DetailExploResultView()
//}

/*
 /// price button Title
 let formatter = NumberFormatter()
 formatter.numberStyle = .currency
 formatter.currencyCode = searchResult.currency
 
 let priceText: String
 if searchResult.price == 0 {
	 priceText = "Free"
 } else if let text = formatter.string(from: searchResult.price as NSNumber) {
	 priceText = text
 } else {
	 priceText = ""
 }
 
 */
