//
//  LoginView.swift
//  Pokemon
//
//  Created by name on 22/04/2025.
//

import SwiftUI

struct LoginView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    @State private var isEmailValid: Bool = false
    @State private var isPasswordValid: Bool = false
    
    var body: some View {
        VStack() {
            Spacer()
                .frame(height: 50)
            
            Text("Welcome back!")
                .font(.title)
            
            Text("Enter your info")
                .font(.title)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("E-mail")
                    .font(.body)
                InputTextField(textFielsType: .email, text: $email)
                    .onChange(of: email) { oldValue, newValue in
                        isEmailValid = !newValue.trimmingCharacters(in: .whitespaces).isEmpty
                    }
            }
            .padding(.vertical)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Password")
                InputTextField(textFielsType: .password, text: $password)
                    .onChange(of: password) { oldValue, newValue in
                        isPasswordValid = !newValue.trimmingCharacters(in: .whitespaces).isEmpty
                    }
            }
            
            Button("Forgot your password?") { print("works") }
                .foregroundColor(Color("defaultLightBlue") )
            
            Spacer()
            
            OnBoardingButton(
                title: "Enter",
                textColor: isEmailValid && isPasswordValid ? .white : .gray,
                backgroundColor: isEmailValid && isPasswordValid ? Color.black : Color.gray.opacity(0.3)
            ) { print("works") }
                .disabled(!(isEmailValid && isPasswordValid))
            
        }
        .padding()
    }
}

#Preview {
    LoginView()
}
