//
//  DetailExploResultView.swift
//  iTunesExplorer
//
//  Created by Loup Martineau on 19/01/2024.
//

import SwiftUI
import Neopuyo

struct DetailExploResultView: View {
	@Binding var isPresenting: Bool
	let exploResult: ExploResult
	let geo: GeometryProxy
	
	
	var body: some View {
			VStack(alignment: .center) {
				Button {
					isPresenting = false
				} label: {
					Image(systemName: "x.circle.fill")
				}
				Text(exploResult.name)
			}
			Text(exploResult.name)
		}
			.frame(width: geo.size.width * 0.7, height: geo.size.height * 0.8)
        // TODO : gestion marge avec simple padding (interne/externe) ? Ou besoin geometryReader
	}
	
}

//#Preview {
//    DetailExploResultView()
//}
