//
//  ContentView.swift
//  iTunesExplorer
//
//  Created by Loup Martineau on 15/01/2024.
//

import SwiftUI
import Neopuyo

struct ExplorerView: View {
	@State private var exploResults = [ExploResult]()
	@State private var showingAlert = false
	@State private var exploResultTargeted: ExploResult? = nil
	@FocusState private var exploFieldFocused: Bool
	@State private var exploFieldInput:String = ""
	
	private var explo = Explo()
	
    var body: some View {
        VStack {
			HStack {
				Image(systemName: "magnifyingglass.circle.fill")
				TextField("Music, app, e-book...", text: $exploFieldInput)
					.submitLabel(.search)
					.disableAutocorrection(true)
					.focused($exploFieldFocused)
					.onSubmit { processingExplo() }
				Button {
					processingExplo()
				} label: {
					Image(systemName: "plus.circle.fill")
				}
				.disabled(exploFieldInput.isEmpty)
				.alert("Network Issue", isPresented: $showingAlert) {
					Button("Ok", role: .cancel) { showingAlert = false }
				} message: {
					Text("Please, check your network settings and retry.")
				}
			}
			List(exploResults) { exploResult in
				RowExploResultView(exploResult: exploResult)
					.onTapGesture {
						exploResultTargeted = exploResult
					}
			}
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
		.padding()
		.onAppear() {
			focusTextFieldOnAppear()
		}
	}
	

	
	// - MARK: Private Methods
	private func processingExplo() {
		withAnimation {
			explo.performExplo(for: exploFieldInput, category: Explo.Category.all) { success in
				if !success {
					showingAlert = true
				} else {
					if case .results(let list) = explo.state {
						exploResults = list
					}
				}
				exploFieldFocused = false
				exploFieldInput = ""
			}
		}
	}
	
	private func focusTextFieldOnAppear() {
		/// Delayed it should not longer needed with iOS >= 16
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
			self.exploFieldFocused = true
		}
	}
}
    

//#Preview {
//    ExplorerView()
//}
