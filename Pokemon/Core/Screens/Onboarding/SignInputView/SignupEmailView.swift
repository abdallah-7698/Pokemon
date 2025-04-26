//
//  SignupEmailView.swift
//  Pokemon
//
//  Created by name on 22/04/2025.
//

import SwiftUI

struct SignupEmailView: View {
    
    @State private var email: String = ""
    @State private var isEmailValid: Bool = false
    
    @EnvironmentObject private var coordinator: Coordinator
    
    var body: some View {
        SignupInputStepView(signupInputCases: .email, input: $email, isInputValid: $isEmailValid) {
            coordinator.push {
                SignupPasswordView()
                    .backButtonBar(title: "Create account") {
                        coordinator.pop()
                    }
            }
        }
        .onChange(of: email) { oldValue, newValue in
            isEmailValid = !newValue.trimmingCharacters(in: .whitespaces).isEmpty
        }
        .backButtonBar(title: "Create account") {
            coordinator.pop()
        }
        
    }
}

#Preview {
    SignupEmailView()
}
