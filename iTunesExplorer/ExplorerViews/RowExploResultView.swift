//
//  RowExploResultView.swift
//  iTunesExplorer
//
//  Created by Loup Martineau on 19/01/2024.
//

import SwiftUI

struct RowExploResultView: View {
	
	let exploResult: ExploResult
	
	var body: some View {
		HStack {
			AsyncImage(url: URL(string: exploResult.imageSmall), transaction: Transaction(animation: .easeOut)) { phase in
				switch phase {
				case .empty:
					ProgressView()
						.progressViewStyle(CircularProgressViewStyle(tint: Color.accentColor))
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
			.frame(width: 40, height: 40)
			.cornerRadius(8.0)
			.overlay(
				RoundedRectangle(cornerRadius: 8.0)
					.stroke(Color.gray, lineWidth: 0.5)
			)
			VStack(alignment: .leading) {
				Text(exploResult.name)
					.font(.body)
				HStack(spacing: 8.0) {
					Text(!exploResult.artist.isEmpty ? exploResult.artist : "Unknown")
					Text(!exploResult.artist.isEmpty ? exploResult.type : "")
						.fontWeight(.light)
					Spacer() // - NOTE: important to spread horizontally row to tapGesture it
				}
				.font(.caption)
				.foregroundStyle(Color("Grey50"))
			}
			.lineLimit(1)
			.truncationMode(.tail)
		}
	}
}

//#Preview {
//    RowExploResultView()
//}
