//
//  ContentView.swift
//  iTunesExplorer
//
//  Created by Loup Martineau on 15/01/2024.
//

import SwiftUI

struct ExplorerView: View {
	@State private var exploResult = [ExploResult]()
	@State private var showingAlert = false
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
			List {
				ForEach(exploResult) { result in
					Text(result.name)
				}
			}
			.cornerRadius(10.0)
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
						exploResult = list
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

// - MARK: to use textfield with button
/*
    start from : https://developer.apple.com/tutorials/app-dev-training/creating-the-edit-view

      HStack {

                    TextField("New Attendee", text: $newAttendeeName)

                    Button(action: {

                        withAnimation {

                            let attendee = DailyScrum.Attendee(name: newAttendeeName)

                            scrum.attendees.append(attendee)

                            newAttendeeName = ""

                        }

                    }) {

                        Image(systemName: "plus.circle.fill")

                    }

                    .disabled(newAttendeeName.isEmpty)

                }
        
        ----------------------------

        vue modale :

        @State private var isPresentingEditView = false

        .sheet(isPresented: $isPresentingEditView) {

            DetailEditView()

        }

        et (de HWS)

        struct SheetView: View {
            @Environment(\.dismiss) var dismiss

            var body: some View {
                Button("Press to dismiss") {
                    dismiss()
                }
                .font(.title)
                .padding()
                .background(.black)
            }
        }

        ---------------------------------

*/

//#Preview {
//    ExplorerView()
//}
