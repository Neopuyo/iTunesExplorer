//
//  ListNoResultView.swift
//  iTunesExplorer
//
//  Created by Loup Martineau on 02/02/2024.
//

import SwiftUI

struct ListNoResultView: View {
    var body: some View {
		Label(
			title: {
				Text("No results")
			},
			icon: { 
				Image(systemName: "questionmark.circle.fill")
					.foregroundColor(Color.complementary)
			}
		)
		.font(.headline)
		.foregroundStyle(Color.accentColor)
		.frame(maxHeight: .infinity, alignment: .center)
    }
}

//#Preview {
//    ListNoResultView()
//}
