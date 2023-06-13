//
//  SubmitView.swift
//  tendableTest
//
//  Created by Kiran Babu Davis on 06/06/2023.
//

import SwiftUI

struct SubmitView: View {
    @EnvironmentObject var submitViewModel: SubmitViewModel
    @EnvironmentObject var submitCoordinator: SubmitCoordinator
    
    var body: some View {
        VStack {
            Text("Inspection")
                .font(.title)
                .padding(.top, 20)

            Spacer()

            Text("Please submit your result for the score")

            Spacer()

            HStack {
                Button(action: {
                   
                }) {
                    Text("Previous")
                        .padding()
                        .foregroundColor(.white)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue))
                }

                Spacer()

                Button(action: {
                    submitCoordinator.submitInspection()
                }) {
                    Text("Submit")
                        .padding()
                        .foregroundColor(.white)
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue))
                }
            }
            .padding()
        }
    }
}

