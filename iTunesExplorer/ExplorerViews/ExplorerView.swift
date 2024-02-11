//
//  ContentView.swift
//  iTunesExplorer
//
//  Created by Loup Martineau on 15/01/2024.
//

import SwiftUI

struct ExplorerView: View {
	@State private var showingAlert = false
	
	@State private var displayExploBar: Bool = false
	@State private var exploBarOpacity = 0.0
	
	@State private var exploFieldInput:String = ""
	@State private var textFieldShouldFocus: Bool = true
	@State private var segmentedControlTag = 0
		
	@StateObject private var explo = ExploUsingCombine()
	@State private var exploResults = [ExploResult]()
	
	
    var body: some View {
		ZStack {
			ExplorerGradient()
			VStack {
				if displayExploBar {
					VStack {
						ExplorerTextFieldView(
							textInput: $exploFieldInput,
							textFieldShouldFocus: $textFieldShouldFocus,
							textIsSubmit: prepareProcessingExplo,
							segmentedControlTag: $segmentedControlTag,
							backAction: backAction
						)
							.padding(.bottom, 12)
					}
					.opacity(exploBarOpacity)
					.alert("Network Issue", isPresented: $showingAlert) {
						Button("Ok", role: .cancel) { showingAlert = false }
					} message: {
						Text("Please, check your network settings and retry.")
					}
				}
				
				switchExploState()
					.frame(maxHeight: .infinity, alignment: .top)
			}
			.padding()
		}
	}

    // - MARK: ViewBuilders
	private func switchExploState() -> some View {
		VStack(spacing: 0) {
			// check state value (when need debug combine)
			// Text(String(describing: explo.state))
			
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
	private func prepareProcessingExplo() {
		processingExplo(input: exploFieldInput, tag: segmentedControlTag)
	}
	
	private func processingExplo(input:String, tag: Int) {
		guard let category = ExploUsingCombine.Category(rawValue: tag) else {
			// - TODO: utiliser un log error ou un fatal error ici au lieu du print ?
			print("Error segmented control - tag = \(tag)")
			return
		}
		explo.performExplo(for: input, category: category) { success in
			if !success {
				showingAlert = true
			} else {
				if case .results(let list) = explo.state {
					exploResults = list
				}
			}
			hideKeyboard()
		}
	}
	
	private func starIsTapped() {
		// - TODO: utiliser une enum pour rendre les state de cet ecran +clairs ?
		withAnimation {
			if displayExploBar && exploFieldInput.isEmpty {
				backAction()
			} else if displayExploBar && !exploFieldInput.isEmpty{
				prepareProcessingExplo()
			} else {
				exploBarOpacity = 1.0
				displayExploBar = true
			}
		}
	}
	
	private func backAction() {
		exploFieldInput = ""
		exploResults = []
		explo.reset()
		textFieldShouldFocus = false
		displayExploBar = false
		exploBarOpacity = 0.0
	}
	
	private enum StarText: CustomStringConvertible {
		case showMenu, hideMenu, launchExplo
		
		var description: String {
			switch self {
			case .showMenu : return "Tap me !"
			case .hideMenu : return "Back"
			case .launchExplo : return "Explore !"
			}
		}
	}
	
	private func getStarText() -> StarText {
		if !displayExploBar {
			return .showMenu
		} else if !exploFieldInput.isEmpty {
			return .launchExplo
		} else {
			return .hideMenu
		}
	}
	

}
    

//#Preview {
//    ExplorerView()
//}
