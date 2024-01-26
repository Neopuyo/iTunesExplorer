//
//  ContentView.swift
//  iTunesExplorer
//
//  Created by Loup Martineau on 15/01/2024.
//

import SwiftUI

struct ExplorerView: View {
	@State private var exploResults = [ExploResult]()
	@State private var showingAlert = false
//	@State private var exploResultTargeted: ExploResult? = nil
	@FocusState private var exploFieldFocused: Bool
	@State private var exploFieldInput:String = ""
	
	@StateObject private var explo = Explo()
	
    var body: some View {
		ZStack {
			// TODO : make pretty gradient light&dark compatible
			Color.accentColor.opacity(0.15)
				.ignoresSafeArea()
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
				.padding(.bottom, 12)
				switchExploState()
					.frame(maxHeight: .infinity, alignment: .top)
			}
			.padding()
			.onAppear() {
				focusTextFieldOnAppear()
			}
		}
	}
	

	
	// - MARK: Private Methods
	private func switchExploState() -> some View {
		VStack(spacing: 0) {
			switch explo.state {
			case .notSearchedYet:
				// TODO : welcome user with picture&Text, button to focus on textField + logoapp icon
				Text("Not Searched Yet")
					.font(.footnote)
					.foregroundStyle(Color.accentColor.opacity(0.5))
			case .loading:
				 ProgressView {
					// TODO : animate text with moving gradient inside typo
					Text("Exploring")
						 .font(.caption)
						 .foregroundStyle(Color.accentColor.opacity(0.5))
				}
			case .noResults:
				Label(
					title: { 
						Text("No results")
					},
					icon: { Image(systemName: "questionmark.circle.fill") }
				)
				.font(.footnote)
				.foregroundStyle(Color.accentColor.opacity(0.5))
			case .results(let results):
				ListExploResultView(exploResults: results)
			}
		}
	}
	
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
		// Delayed it should not longer needed with iOS >= 16
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
			self.exploFieldFocused = true
		}
	}
}
    

//#Preview {
//    ExplorerView()
//}
