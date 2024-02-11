//
//  ListExploResultView.swift
//  iTunesExplorer
//
//  Created by Loup Martineau on 26/01/2024.
//

import SwiftUI
import Neopuyo

struct ListExploResultView: View {
	
	let exploResults: [ExploResult]
	@State private var exploResultTargeted: ExploResult? = nil
	
    var body: some View {
		List(exploResults) { exploResult in
			RowExploResultView(exploResult: exploResult)
				.border(.pink)
				.onTapGesture {
					exploResultTargeted = exploResult
				}
		}
		.listStyle(.plain)
		.cornerRadius(12.0)
		.sheet(item: $exploResultTargeted, onDismiss: {
			exploResultTargeted = nil
		}, content: { exploResult in
			GeometryReader { geo in
				DetailExploResultView(exploResult: exploResult, geo: geo)
					.background(TranslucidSheet())
					.position(x: geo.frame(in: .global).midX, y: geo.frame(in: .global).midY - geo.size.height * 0.08)
				
			}
		})
    }
}

//#Preview {
//    ListExploResultView()
//}
