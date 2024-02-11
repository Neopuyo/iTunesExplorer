//
//  ExplorerTextFieldView.swift
//  iTunesExplorer
//
//  Created by Loup Martineau on 09/02/2024.
//

import SwiftUI


struct ExplorerTextFieldView: View {
	
	//text field
	@Binding var textInput:String
	@Binding var textFieldShouldFocus: Bool
	@FocusState private var exploFieldFocused: Bool
	
	let textIsSubmit: () -> ()
	
	// segmented control
	@State private var displaySegmentedControl: Bool = false
	@State private var segmentedControlOpacity = 0.0
	@Binding var segmentedControlTag: Int
	
	let backAction: () -> ()
	
	
	var body: some View {
		
		// - TODO: make custom Style for same images/button
		VStack {
			VStack {
				
				// Back & Filters Buttons
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
				
				// Explo Bar text Field
				HStack {
					Image(systemName: "magnifyingglass")
						.foregroundStyle(.accent)
						.font(.body)
						.padding(.leading)
					TextField("Music, app, e-book...", text: $textInput)
						.submitLabel(.search)
						.disableAutocorrection(true)
						.focused($exploFieldFocused)
						.onSubmit {
							willSubmitInput()
						}
					Button {
						// TODO : set up microphoneButton action
					} label: {
						Image(systemName: "mic.circle.fill")
							.foregroundStyle(.accent)
							.font(.title)
							.padding(.trailing)
					}
				}
				.padding(.vertical, 6)
				.background(Color.grey50.opacity(0.25))
				.cornerRadius(12.0)
				.onAppear {
					exploFieldFocused = true
				}
				.onChange(of: textFieldShouldFocus) { newValue in
					exploFieldFocused = newValue
				}
			}
			
			// Segmented control
			if displaySegmentedControl {
				segmentedControlView
					.transition(.move(edge: .top))
			}
		}
		
	}
	
	// - MARK: View Builders
	
	
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
				willSubmitInput()
			}
			.opacity(segmentedControlOpacity)
		
	}
	
	// - MARK: Private Methods
	private func showFiltersIsTapped() {
		// - TODO: improve animation with a vertical move effect
		withAnimation {
			segmentedControlOpacity =  displaySegmentedControl ? 0.0 : 1.0
			displaySegmentedControl.toggle()
		}
	}
	
	private func willSubmitInput() {
		exploFieldFocused = false
		textIsSubmit()
	}
	
	
}

//#Preview {
//    ExplorerTextFieldView()
//}
