//
//  DetailExploResultView.swift
//  iTunesExplorer
//
//  Created by Loup Martineau on 19/01/2024.
//

import SwiftUI

struct DetailExploResultView: View {
	@Binding var isPresenting: Bool
	let exploResult: ExploResult
	
	
    var body: some View {
		VStack(alignment: .center) {
			Button {
				isPresenting = false
			} label: {
				Image(systemName: "x.circle.fill")
			}
		}
		Text(exploResult.name)
    }
}

//#Preview {
//    DetailExploResultView()
//}
