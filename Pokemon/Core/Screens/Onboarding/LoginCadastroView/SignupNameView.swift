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
    
    var body: some View {
        SignupInputStepView(signupInputCases: .username, input: $name, isInputValid: $isNameValid) {
            print("work")
        }.onChange(of: name) { oldValue, newValue in
            isNameValid = !newValue.trimmingCharacters(in: .whitespaces).isEmpty
        }
    }
}

#Preview {
    SignupNameView()
}
