//
//  SignupPasswordView.swift
//  Pokemon
//
//  Created by name on 22/04/2025.
//

import SwiftUI

struct SignupPasswordView: View {
    @State private var password: String = ""
    @State private var isPasswordValid: Bool = false
    
    @EnvironmentObject private var coordinator: Coordinator

    
    var body: some View {
        SignupInputStepView(signupInputCases: .password, input: $password, isInputValid: $isPasswordValid) {
            coordinator.push {
                SignupNameView()
                   
            }
        }.onChange(of: password) { oldValue, newValue in
            isPasswordValid = !newValue.trimmingCharacters(in: .whitespaces).isEmpty
        }
        .backButtonBar(title: "Create account") {
            coordinator.pop()
        }
    }
}

#Preview {
    SignupPasswordView()
}
