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
	@State private var exploBarOpacity = 0.0
	@State private var segmentedControlOpacity = 0.0
	
	@StateObject private var explo = ExploUsingCombine()
	@State private var displayExploBar: Bool = false
	@State private var displaySegmentedControl: Bool = false
	
	private var isDeleteUp: Bool {
		(explo.state != .notSearchedYet || exploFieldFocused == true ) && !exploFieldInput.isEmpty
	}
	
    var body: some View {
		ZStack {
			ExplorerGradient()
			VStack {
				if displayExploBar {
					VStack {
//						ExplorerTextFieldView()
//							.padding(.bottom, 12)
						exploFieldStackView
							.padding(.bottom, 12)
						if displaySegmentedControl {
							segmentedControlView
						}
					}
					// TODO : - don't forget putting back the alert after textfield rework
					.opacity(exploBarOpacity)
				}
				
				switchExploState()
					.frame(maxHeight: .infinity, alignment: .top)
			}
			.padding()
		}
	}

    // - MARK: ViewBuilders
	@ViewBuilder
	private var exploFieldStackView: some View {
		// - TODO: make custom Style for same images/button
		// - Extract-Rework as a view ?
		
		VStack {
			HStack {
				Button {
					backAction()
				} label: {
					Image(systemName: "chevron.backward.circle.fill")
						.foregroundStyle(.accent)
						.font(.title)
						.padding(.leading)
				}
				Spacer()
				Button {
					showFiltersIsTapped()
				} label: {
					Image(systemName: displaySegmentedControl ? "tag.circle.fill" : "tag.circle")
						.foregroundStyle(.accent)
						.font(.title)
						.padding(.trailing)
				}
			}
			HStack {
				Image(systemName: "magnifyingglass")
					.foregroundStyle(.accent)
					.font(.body)
					.padding(.leading)
				TextField("Music, app, e-book...", text: $exploFieldInput)
					.submitLabel(.search)
					.disableAutocorrection(true)
					.focused($exploFieldFocused)
					.onSubmit { processingExplo(categoryTag: segmentedControlTag) }
				Button {
					//				deleteIsTapped()
					// TODO : set up microphoneButton action
				} label: {
					Image(systemName: "mic.circle.fill")
						.foregroundStyle(.accent)
						.font(.title)
						.padding(.trailing)
				}
				//.disabled(!isDeleteUp)
				.alert("Network Issue", isPresented: $showingAlert) {
					Button("Ok", role: .cancel) { showingAlert = false }
				} message: {
					Text("Please, check your network settings and retry.")
				}
			}
			.padding(.vertical, 6)
			.background(Color.grey50.opacity(0.25))
			.cornerRadius(12.0)
		}
	}
	
	@ViewBuilder
	private var segmentedControlView: some View {
		Picker("Explo search filter", selection: $segmentedControlTag) {
			Text("All").tag(0)
			Text("Music").tag(1)
			Text("Apps").tag(2)
			Text("E-book").tag(3)
			Text("Movies").tag(4)
		}.pickerStyle(.segmented)
		.onChange(of: segmentedControlTag) { tag in
			processingExplo(categoryTag: tag)
		}
		.opacity(segmentedControlOpacity)
		
	}
	
	private func switchExploState() -> some View {
		VStack(spacing: 0) {
			switch explo.state {
			case .notSearchedYet:
				ListNotSearchedYetView(starText:getStarText().description) { starIsTapped() }
			case .loading:
				ListLoadingView()
			case .noResults:
				ListNoResultView()
			case .results(let results):
				ListExploResultView(exploResults: results)
			}
		}
	}
	
	// - MARK: Private Methods
	private func processingExplo(categoryTag: Int) {
		guard let category = ExploUsingCombine.Category(rawValue: categoryTag) else {
            // - TODO: utiliser un log error ou un fatal error ici au lieu du print ?
			print("Error segmented control - tag = \(categoryTag)")
			return
		}
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
	
	private func starIsTapped() {
		// - TODO: utiliser une enum pour rendre les state de cet ecran +clairs ?
		withAnimation {
			if displayExploBar && exploFieldInput.isEmpty {
				backAction()
			} else {
				processingExplo(categoryTag: segmentedControlTag)
				exploBarOpacity = 1.0
				displayExploBar = true
				exploFieldFocused.toggle()
			}
		}
	}
	
	private func backAction() {
		exploFieldInput = ""
		exploResults = []
		explo.reset()
		exploFieldFocused = false
		displayExploBar = false
		exploBarOpacity = 0.0
	}
	
	private func showFiltersIsTapped() {
//		defer { displaySegmentedControl.toggle() }
		// - TODO: improve animation with a vertical move effect
		withAnimation {
			segmentedControlOpacity =  displaySegmentedControl ? 0.0 : 1.0
			displaySegmentedControl.toggle()
		}
	}
	
	private func deleteIsTapped() {
		exploFieldInput = ""
		exploFieldFocused = true
		exploResults = []
		explo.reset()
	}
	
	private enum StarText: CustomStringConvertible {
		case showMenu, hideMenu, launchExplo
		
		var description: String {
			switch self {
			case .showMenu : return "Tap me !"
			case .hideMenu : return "Back"
			case .launchExplo : return "Search"
			}
		}
	}
	
	private func getStarText() -> StarText {
		if !displayExploBar {
			return .showMenu
		} else if isDeleteUp {
			return .launchExplo
		} else {
			return .hideMenu
		}
	}
	

}
    

//#Preview {
//    ExplorerView()
//}
