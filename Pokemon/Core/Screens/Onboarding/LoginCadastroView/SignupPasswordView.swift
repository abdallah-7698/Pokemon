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
    
    var body: some View {
        SignupInputStepView(signupInputCases: .password, input: $password, isInputValid: $isPasswordValid) {
            print("work")
        }.onChange(of: password) { oldValue, newValue in
            isPasswordValid = !newValue.trimmingCharacters(in: .whitespaces).isEmpty
        }
    }
}

#Preview {
    SignupPasswordView()
}
