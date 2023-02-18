//
//  LoginForm.swift
//  ah2404
//
//  Created by Morris Albers on 2/18/23.
//

import SwiftUI
import FirebaseAuth

struct LoginForm: View {
    
    @Binding var formShowing: Bool
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var errorMessage: String?
    
    var body: some View {
        
        NavigationView {
            
            Form {
                
                Section {
                    TextField("Email", text: $email).disableAutocorrection(true)
                    SecureField("Password", text: $password)
                }
                
                if errorMessage != nil {
                    Section {
                        Text(errorMessage!)
                    }
                }
                
                Button(action: {
                    
                    // Perform login
                    signIn()
                    
                }, label: {
                    HStack {
                        Spacer()
                        Text("Sign in")
                        Spacer()
                    }
                })
            }
            .navigationTitle("Sign In")
        }
        
    }
    
    func signIn() {
        
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            
            DispatchQueue.main.async {
                if error == nil {
                    
                    // Sign in successful
                    
                    // Dismiss this sheet
                    formShowing = false
                }
                else {
                    // If there's an issue with logging in
                    errorMessage = error!.localizedDescription
                }
            }
        }
    }
}

struct LoginForm_Previews: PreviewProvider {
    static var previews: some View {
        LoginForm(formShowing: Binding.constant(true))
    }
}
