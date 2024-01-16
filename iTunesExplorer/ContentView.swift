//
//  ContentView.swift
//  iTunesExplorer
//
//  Created by Loup Martineau on 15/01/2024.
//

import SwiftUI

struct ContentView: View {
	@State private var input:String = ""
	
    var body: some View {
        VStack {
			HStack {
				Image(systemName: "magnifyingglass.circle.fill")
				TextField("Music, app, e-book...", text: $input)
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
//    ContentView()
//}
