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
	
	var nameMain: String {
		exploResult.name.components(separatedBy: "(")[0]
	}
	
	var nameSecond: String {
		let array = exploResult.name.components(separatedBy: "(")
		return array.count > 1 ? array[1].replacingOccurrences(of: ")", with: "") : ""
	}
	
	
	var body: some View {
		VStack(alignment: .center, spacing:20) {
			Button {
				dismiss()
			} label: {
				Image(systemName: "x.circle.fill")
					.font(.headline)
			}
			.frame(maxWidth: .infinity, alignment: .trailing)
			VStack {
				AsyncImage(url: URL(string: exploResult.imageLarge), transaction: Transaction(animation: .easeOut)) { phase in
					switch phase {
					case .empty:
						ProgressView()
					case .success(let image):
						image
							.resizable()
							.scaledToFill()
							.transition(.scale(scale: 0.75, anchor: .center))
					case .failure(_):
						Image(systemName: "x.square.fill")
							.font(.headline)
					@unknown default:
						EmptyView()
					}
				}
				.frame(width: 100, height: 100)
				.cornerRadius(8.0)
				.overlay(
					RoundedRectangle(cornerRadius: 8.0)
						.stroke(Color.accentColor, lineWidth: 3.5)
				)
				VStack(spacing:0) {
					Text(nameMain)
					if !nameSecond.isEmpty {
						Text(nameSecond)
							.font(.caption)
							.foregroundColor(.secondary)
					}
				}
				.multilineTextAlignment(.center)
				.padding(.bottom, 20)
				Text(exploResult.artistName ?? "unknown")
					.foregroundColor(Color("AccentColor"))
					.multilineTextAlignment(.center)
				VStack(alignment: .leading, spacing:0) {
					Label {
						Text("Type")
							.frame(minWidth: 60, alignment: .leading)
							.foregroundColor(.secondary)
						Text(":")
							.padding(.trailing, 12)
							.foregroundColor(.secondary)
						Text(exploResult.type)
							
					} icon: {
						Circle()
							.fill(Color("AccentColor"))
							.frame(width: 4, height: 4, alignment: .center)
					}
					Label {
						Text("Genre")
							.frame(minWidth: 60, alignment: .leading)
							.foregroundColor(.secondary)
						Text(":")
							.padding(.trailing, 12)
							.foregroundColor(.secondary)
						Text(exploResult.genre)
							
					} icon: {
						Circle()
							.fill(Color("AccentColor"))
							.frame(width: 4, height: 4, alignment: .center)
					}
				}
				.font(.caption)
				.padding(.bottom, 20)
				Button {
					// Nothing to do yet
				} label: {
					Text(getPrice())	
				}
				.buttonStyle(ScaleOnTap())
				.padding(.horizontal)
				.frame(maxWidth: .infinity, alignment: .trailing)
			}
		}
		.frame(maxWidth: geo.size.width * 0.65)
		.padding()
		.background(.ultraThinMaterial)
		.background(Color.accentColor.opacity(0.35))
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
