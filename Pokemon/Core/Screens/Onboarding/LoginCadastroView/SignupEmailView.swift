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
    
    var body: some View {
        SignupInputStepView(signupInputCases: .email, input: $email, isInputValid: $isEmailValid) {
            print("work")
        }.onChange(of: email) { oldValue, newValue in
            isEmailValid = !newValue.trimmingCharacters(in: .whitespaces).isEmpty
        }
    }
}

#Preview {
    SignupEmailView()
}
