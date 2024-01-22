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
            
            /* TODO 1
              partir de l'ex de tuto app apple : 
              https://developer.apple.com/tutorials/app-dev-training/handling-errors
              > + simple juste un padding + background(.thinmaterial...)
              > pas de geoReader, simplifier au max
            
            */
            /* TODO 2
              utiliser : 
              NavigationStack {

            DetailEditView(scrum: $newScrum) // ici la VStack

                .toolbar {

                    ToolbarItem(placement: .cancellationAction) {

                        Button (... mon bouton ici)

                    }

             [!] si ajout NavStack rajoute pas une couche avec mes pb de background
            */

            // TODO 3  to have rounded corner VSTACK clean : 
            // - try using mask 
            // - or just using .background(.clear) + corner radius ?
            // - or not use .background() in parent view ??
            // - or edit the BackgroundBlurView() package

	}
	
}

//#Preview {
//    DetailExploResultView()
//}
