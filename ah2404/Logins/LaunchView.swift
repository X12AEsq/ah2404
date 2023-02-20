//
//  LaunchView.swift
//  ah2404
//
//  Created by Morris Albers on 2/18/23.
//

import SwiftUI
import FirebaseAuth

@available(iOS 15.0, *)
struct LaunchView: View {
    
    @State var loggedIn = false
    @State var loginFormShowing = false
    @State var createFormShowing = false
//    @State var showingEditVehicleView = false
    
    var body: some View {
        
        // Check the logged in property and show the appropriate view
        if !loggedIn {
        
            VStack (spacing: 20) {
                
                // Sign in button
                Button {
                    // Show the login form
                    loginFormShowing = true
                } label: {
                    Text("Sign In")
                }
                .sheet(isPresented: $loginFormShowing, onDismiss: checkLogin) {
                    LoginForm(formShowing: $loginFormShowing)
                }
                
                // Create account button
                Button {
                    createFormShowing = true
                } label: {
                    Text("Create Account")
                }
                .sheet(isPresented: $createFormShowing, onDismiss: checkLogin) {
                    CreateForm(formShowing: $createFormShowing)
                }
                
            }
            .onAppear {
                checkLogin()
            }
        }
        else {
            
            // Show logged in view
//            StartupView(loggedIn: $loggedIn)
            ContentView()
//            ContentView(loggedIn: $loggedIn)
        }
    }
    
    func checkLogin() {
        
        loggedIn = Auth.auth().currentUser == nil ? false : true
    }
}

@available(iOS 15.0, *)
struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}
