//
//  SignSuccessView.swift
//  Pokemon
//
//  Created by name on 22/04/2025.
//

import SwiftUI

struct SignSuccessView: View {
    
    enum SignSuccessCases {
        case signup
        case login
        
        var imageString: String {
            switch self {
            case .signup: return "signupSuccessImage"
            case .login:  return "loginSuccessImage"
            }
        }
        
        var title: String {
            switch self {
            case .signup: return "Your account has been successfully created!"
            case .login:  return "Welcome back, Trainer!"
            }
        }
        
        var description: String {
            switch self {
            case .signup: return "Welcome, Coach! We’re excited to follow your journey."
            case .login:  return "We hope you have had a long journey since you last visited us."
            }
        }
    }
    
    let signSuccessCases: SignSuccessCases
    
    @EnvironmentObject private var coordinator: Coordinator
    
    var body: some View {
        VStack {
            OnBoardingStackView(imageName: signSuccessCases.imageString, title: signSuccessCases.title, description: signSuccessCases.description)
                .padding(.bottom, 30)
                OnBoardingButton(title: "Continue") {
                    coordinator.push {
                        PokemonView()
                            .navigationBarBackButtonHidden()
                    }
                }
        }
        .backButtonBar(title: "Enter") {
            coordinator.pop()
        }
    }
}

#Preview {
    SignSuccessView(signSuccessCases: .signup)
}
