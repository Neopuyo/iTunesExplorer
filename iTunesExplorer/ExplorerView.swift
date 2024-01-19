//
//  ContentView.swift
//  iTunesExplorer
//
//  Created by Loup Martineau on 15/01/2024.
//

import SwiftUI

struct ExplorerView: View {
	@State private var input:String = ""
	@StateObject private var explo = Explo()
	
    var body: some View {
        VStack {
			HStack {
				Image(systemName: "magnifyingglass.circle.fill")
				TextField("Music, app, e-book...", text: $input)
				Button(action: {

					withAnimation {
						explo.performExplo(for: input, category: Explo.Category.all) { success in
							if !success {
								// TODO show error network alert
							} else {
								if case .results(let list) = explo.state {
									for item in list {
										print ("item = \(item)")
									}
								}
							}
						}
					}

				}) {
					Image(systemName: "plus.circle.fill")

				}
				.disabled(input.isEmpty)
				
			}
			Spacer()
        }
        .padding()
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
