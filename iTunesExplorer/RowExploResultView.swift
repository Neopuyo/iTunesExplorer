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
			AsyncImage(url: URL(string: exploResult.imageSmall)) { phase in
				if let image = phase.image {
					image
						.resizable()
						.scaledToFill()
				} else if phase.error != nil {
					Image(systemName: "x.square.fill")
						.font(.headline)
				} else {
					ProgressView()
				}
			}
			.frame(width: 40, height: 40)
			.background(Color.gray)
			.clipShape(RoundedRectangle(cornerSize: CGSize(width: 5, height: 1.25)))
			Text(exploResult.name)
				.font(.caption)
				.lineLimit(1)
				.truncationMode(.tail)
		}
    }
}

//#Preview {
//    RowExploResultView()
//}
