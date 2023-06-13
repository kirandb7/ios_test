//
//  ContentView.swift
//  tendableTest
//
//  Created by Kiran Babu Davis on 08/06/23.
//

import SwiftUI
import Combine

struct LoginView: View {
    @EnvironmentObject var userAuth: UserAuth
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Email", text: $userAuth.email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                SecureField("Password", text: $userAuth.password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button(action: {
                    userAuth.signIn(email: userAuth.email, password: userAuth.password)
                }) {
                    Text("Sign In")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                .padding()
                .disabled(!userAuth.formIsValid)
                .opacity(buttonOpacity)
                
            }
            .padding()
            .navigationTitle("Login")
        }
        .fullScreenCover(isPresented: $userAuth.isLogged) {
            InspectionView()
        }
    }
    var buttonOpacity: Double {
        return userAuth.formIsValid ? 1 : 0.5
      }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
