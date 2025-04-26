//
//  SignupNameView.swift
//  Pokemon
//
//  Created by name on 22/04/2025.
//

import SwiftUI

struct SignupNameView: View {
    @State private var name: String = ""
    @State private var isNameValid: Bool = false
    
    @EnvironmentObject private var coordinator: Coordinator

    
    var body: some View {
        SignupInputStepView(signupInputCases: .username, input: $name, isInputValid: $isNameValid) {
            coordinator.push {
                SignSuccessView(signSuccessCases: .signup)
            }
        }.onChange(of: name) { oldValue, newValue in
            isNameValid = !newValue.trimmingCharacters(in: .whitespaces).isEmpty
        }
        .backButtonBar(title: "Create account") {
            coordinator.pop()
        }
    }
}

#Preview {
    SignupNameView()
}
