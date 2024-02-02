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
	
	private var isActive: Bool {
		explo.state != .notSearchedYet || exploFieldFocused == true
	}
	
	private var isDeleteUp: Bool {
		isActive && !exploFieldInput.isEmpty
	}
	
    var body: some View {
		ZStack {
			ExplorerGradient()
			VStack {
				Text("isActive : \(isActive.description)")
				if isActive {
					VStack {
						HStack {
							Image(systemName: "magnifyingglass.circle.fill")
								.foregroundStyle(isActive ? .accent : .primary)
							TextField("Music, app, e-book...", text: $exploFieldInput)
								.submitLabel(.search)
								.disableAutocorrection(true)
								.focused($exploFieldFocused)
								.onSubmit { processingExplo(categoryTag: segmentedControlTag) }
							Button {
								deleteIsTapped()
							} label: {
								Image(systemName: "delete.left.fill")
							}
							.disabled(!isDeleteUp)
							.opacity(isDeleteUp ? 1 : 0)
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
								// - TODO: Fix infinite progressView on image when exploring with swaping segmented control
								// [+] -> ici une fonction qui vide la liste avant ?
								processingExplo(categoryTag: tag)
							}
					}
				}
				
				switchExploState()
					.frame(maxHeight: .infinity, alignment: .top)
			}
			.padding()
		}
	}
	
	// - MARK: Private Methods
	private func switchExploState() -> some View {
		VStack(spacing: 0) {
			switch explo.state {
			case .notSearchedYet:
				ListNotSearchedYetView() { starIsTapped() }
			case .loading:
				ListLoadingView()
			case .noResults:
				ListNoResultView()
			case .results(let results):
				ListExploResultView(exploResults: results)
			}
		}
	}
	
	private func processingExplo(categoryTag: Int) {
		guard let category = Explo.Category(rawValue: categoryTag) else {
            // - TODO: utiliser un log error ou un fatal error ici au lieu du print ?
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
			}
		}
	}
	
	private func starIsTapped() {
		processingExplo(categoryTag: segmentedControlTag)
		exploFieldFocused.toggle()
	}
	
	private func deleteIsTapped() {
		exploFieldInput = ""
		exploFieldFocused = true
		exploResults = []
		explo.reset()
	}
	

}
    

//#Preview {
//    ExplorerView()
//}
