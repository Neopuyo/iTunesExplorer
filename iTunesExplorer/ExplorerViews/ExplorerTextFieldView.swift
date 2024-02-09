//
//  ExplorerTextFieldView.swift
//  iTunesExplorer
//
//  Created by Loup Martineau on 09/02/2024.
//

import SwiftUI

protocol ExploTextFieldDelegate : AnyObject {
	func submitExplo(with text:String)
	func exploTextFieldFocusChanged(to newFocus:Bool)
}

struct ExplorerTextFieldView: View {
	@State private var exploFieldInput:String = ""
	@FocusState private var exploFieldFocused: Bool
	
	weak var delegate : ExploTextFieldDelegate?
	
	
	
    var body: some View {
        
		// - TODO: make custom Style for same images/button
		// - Extract-Rework as a view ?
		
		VStack {
//			HStack {
//				Button {
//				backAction()
//				} label: {
//					Image(systemName: "chevron.backward.circle.fill")
//						.foregroundStyle(.accent)
//						.font(.title)
//						.padding(.leading)
//				}
//				Spacer()
//				Button {
//					showFiltersIsTapped()
//				} label: {
//				Image(systemName: displaySegmentedControl ? "tag.circle.fill" : "tag.circle")
//					Image(systemName: "tag.circle")
//						.foregroundStyle(.accent)
//						.font(.title)
//						.padding(.trailing)
//				}
//			}
			
			HStack {
				Image(systemName: "magnifyingglass")
					.foregroundStyle(.accent)
					.font(.body)
					.padding(.leading)
				TextField("Music, app, e-book...", text: $exploFieldInput)
					.submitLabel(.search)
					.disableAutocorrection(true)
					.focused($exploFieldFocused)
					.onSubmit {
						//processingExplo(categoryTag: segmentedControlTag)
					}
//				Button {
//					//				deleteIsTapped()
//					// TODO : set up microphoneButton action
//				} label: {
//					Image(systemName: "mic.circle.fill")
//						.foregroundStyle(.accent)
//						.font(.title)
//						.padding(.trailing)
//				}
				//.disabled(!isDeleteUp)
			}
			.padding(.vertical, 6)
			.background(Color.grey50.opacity(0.25))
			.cornerRadius(12.0)
			 
			 
		}
		
    }
	
	
	// - MARK: Private Methods

	
	
}

//#Preview {
//    ExplorerTextFieldView()
//}
