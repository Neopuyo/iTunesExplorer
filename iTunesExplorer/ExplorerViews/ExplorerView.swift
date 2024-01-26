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
	@FocusState private var exploFieldFocused: Bool
	@State private var exploFieldInput:String = ""
	@State private var segmentedControlTag = 0
	
	@StateObject private var explo = Explo()
	
	var canClear: Bool {
		explo.state != .notSearchedYet
	}
	
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
						.onSubmit { processingExplo(categoryTag: segmentedControlTag) }
					Button {
						if canClear {
							exploFieldInput = ""
							exploFieldFocused = true
							explo.cancel()
						} else {
							processingExplo(categoryTag: segmentedControlTag)
						}
					} label: {
						Image(systemName: "plus.circle.fill")
							.animation(.easeInOut, value: canClear)
							.rotationEffect(Angle(degrees: canClear ? 45.0 : 0))
					}
					.disabled(exploFieldInput.isEmpty)
					.alert("Network Issue", isPresented: $showingAlert) {
						Button("Ok", role: .cancel) { showingAlert = false }
					} message: {
						Text("Please, check your network settings and retry.")
					}
				}
				.padding(.bottom, 12)
				
				Picker("Explo search filter", selection: $segmentedControlTag) {
					Text("All").tag(0)
					Text("Music").tag(1)
					Text("Apps").tag(2)
					Text("E-book").tag(3)
				}.pickerStyle(.segmented)
					.onChange(of: segmentedControlTag) { tag in
						processingExplo(categoryTag: tag)
					}
				
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
				// - TODO: welcome user with picture&Text, button to focus on textField + logoapp icon
				Text("Not Searched Yet")
					.font(.footnote)
					.foregroundStyle(Color.accentColor.opacity(0.5))
			case .loading:
				 ProgressView {
					// - TODO: animate text with moving gradient inside typo
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
	
	private func processingExplo(categoryTag: Int) {
		guard let category = Explo.Category(rawValue: categoryTag) else {
			print("Error segmented control - tag = \(categoryTag)")
			return
		}
		withAnimation {
			explo.performExplo(for: exploFieldInput, category: category) { success in
				if !success {
					showingAlert = true
				} else {
					if case .results(let list) = explo.state {
						exploResults = list
					}
				}
				exploFieldFocused = false
//				exploFieldInput = ""
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
