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
	@State private var menuOpacity = 0.0
	
	@StateObject private var explo = ExploUsingCombine()
	@State private var isExploActive: Bool = false
	
	private var isDeleteUp: Bool {
		(explo.state != .notSearchedYet || exploFieldFocused == true ) && !exploFieldInput.isEmpty
	}
	
    var body: some View {
		ZStack {
			ExplorerGradient()
			VStack {
				if isExploActive {
					VStack {
						exploFieldStackView
							.padding(.bottom, 12)
						segmentedControlView
					}
					.opacity(menuOpacity)
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
		HStack {
			Image(systemName: "magnifyingglass.circle.fill")
				.foregroundStyle(.accent)
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
			.alert("Network Issue", isPresented: $showingAlert) {
				Button("Ok", role: .cancel) { showingAlert = false }
			} message: {
				Text("Please, check your network settings and retry.")
			}
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
			if isExploActive && exploFieldInput.isEmpty {
				menuOpacity = 0.0
				isExploActive = false
			} else {
				processingExplo(categoryTag: segmentedControlTag)
				menuOpacity = 1.0
				isExploActive = true
				exploFieldFocused.toggle()
			}
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
		if !isExploActive {
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
