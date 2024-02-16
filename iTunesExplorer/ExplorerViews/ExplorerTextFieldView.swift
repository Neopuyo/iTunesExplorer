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
						Image(systemName: "chevron.backward.circle")
							.foregroundStyle(.accent)
							.font(.title2)
							.padding(.leading)
					}
					Spacer()
					Button {
						showFiltersIsTapped()
					} label: {
						Image(systemName: displaySegmentedControl ? "ellipsis.circle.fill" : "ellipsis.circle")
							.foregroundStyle(Color.whiteLock)
							.font(.title2)
							.padding(.trailing)
					}
				}
				.padding(.bottom, 6)
				
				// Explo Bar text Field
				HStack {
					Image(systemName: "magnifyingglass")
						.foregroundStyle(Color.grey50.opacity(0.4))
						.font(.body)
						.padding(.leading)
					TextField("Music, app, e-book...", text: $textInput)
						.submitLabel(.search)
						.disableAutocorrection(true)
						.focused($exploFieldFocused)
						.onSubmit {
							willSubmitInput(from: .keyboard)
						}
					Button {
						// TODO : set up microphoneButton action
					} label: {
						Image(systemName: "mic.fill")
							.foregroundStyle(Color.grey50.opacity(0.4))
							.font(.body)
							.padding(.trailing)
					}
				}
				.padding(.vertical, 6)
				.background(Color.whiteLock.opacity(0.10))
				.cornerRadius(8.0)
				.overlay(
					RoundedRectangle(cornerRadius: 8.0)
						.stroke(Color.whiteLock.opacity(0.20), lineWidth: 1.0)
				)
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
					.opacity(segmentedControlOpacity)
					.transition(AnyTransition.opacity.combined(with: .move(edge: .top)))
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
		.cornerRadius(8.0)
		.overlay(
			RoundedRectangle(cornerRadius: 8.0)
				.stroke(Color.whiteLock.opacity(0.20), lineWidth: 1.0)
		)
		.onChange(of: segmentedControlTag) { tag in
			willSubmitInput(from: .segmentedControl)
		}
	}
	
	// - MARK: Private Methods
	private func showFiltersIsTapped() {
		// - TODO: improve animation with a vertical move effect
		withAnimation {
			displaySegmentedControl.toggle()
			segmentedControlOpacity = displaySegmentedControl ? 1.0 : 0.0
		}
	}
	
	private func willSubmitInput(from source: SubmitSource) {
		if source == .keyboard && textInput.isEmpty {
			backAction()
		} else {
			textIsSubmit()
		}
	}
	
	private enum SubmitSource {
		case keyboard, segmentedControl
	}
	
}

extension Shape {
	func fill<Fill: ShapeStyle, Stroke: ShapeStyle>(_ fillStyle: Fill, strokeBorder strokeStyle: Stroke, lineWidth: Double = 1) -> some View {
		self
			.stroke(strokeStyle, lineWidth: lineWidth)
			.background(self.fill(fillStyle))
	}
}

//#Preview {
//    ExplorerTextFieldView()
//}
