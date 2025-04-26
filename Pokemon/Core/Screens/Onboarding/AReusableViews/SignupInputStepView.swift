//
//  SignupInputStepView.swift
//  Pokemon
//
//  Created by name on 22/04/2025.
//

import SwiftUI

struct SignupInputStepView: View {
    
    enum SignupInputCases {
        case email
        case password
        case username
        
        var title: String {
            switch self {
            case .email: return "Let's get started!"
            case .password: return "Now..."
            case .username: return "To finish"
            }
        }
        
        var subtitle: String {
            switch self {
            case .email: return "What is your email?"
            case .password: return "Create a password"
            case .username: return "What is your name?"
            }
        }
        
        var hint: String {
            switch self {
            case .email: return "Please use a valid email address."
            case .password: return "Your password must be at least 8 characters long"
            case .username: return "This will be your username in the app."
            }
        }
        
        var buttonTitle: String {
            switch self {
            case .email: return "Continue"
            case .password: return "Continue"
            case .username: return "Create account"
            }
        }
        
        var tfCases: TFCases {
            switch self {
            case .email: return .email
            case .password:return .password
            case .username: return .username
            }
        }
    }
    
    let signupInputCases: SignupInputCases
    @Binding var input: String
    @Binding var isInputValid: Bool

    let onContinue: () -> Void
    
    @EnvironmentObject private var coordinator: Coordinator
    
    var body: some View {
        VStack() {
            Spacer()
                .frame(height: 50)
            
            Text(signupInputCases.title)
                .font(.title)
            
            Text(signupInputCases.subtitle)
                .font(.title)
                .fontWeight(.semibold)
                .foregroundColor(.primary)
            
            InputTextField(textFielsType: signupInputCases.tfCases, text: $input)
                .padding(.bottom)
            
            Text(signupInputCases.hint)
                .font(.caption)
                .foregroundColor(.gray)
            
            Spacer()
            
            OnBoardingButton(
                title: "Continuar",
                textColor: isInputValid ? .white : .gray,
                backgroundColor: isInputValid ? Color.black : Color.gray.opacity(0.3)
            ) { onContinue() }
                .disabled(!isInputValid)
            
        }
        .padding()
        
    }
}

#Preview {
    SignupInputStepView(
        signupInputCases: .email,
        input: .constant(""),
        isInputValid: .constant(true)
    ) {
        print("change")
    }
}
