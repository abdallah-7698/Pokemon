//
//  SignView.swift
//  Pokemon
//
//  Created by name on 22/04/2025.
//

import SwiftUI

struct SignView: View {
    
    enum Regestration {
        case signup
        case login
        
        var imageName: String {
            switch self {
            case .signup: return "signupImage"
            case .login:  return "loginImage"
            }
        }
        
        var title: String {
            switch self {
            case .signup: return "There is little time left to explore this world!"
            case .login:  return "So good to see you here again!"
            }
        }
    }
    
    let regestration: Regestration
    
    @EnvironmentObject private var coordinator: Coordinator
    
    var body: some View {
        VStack {
            OnBoardingStackView(imageName: regestration.imageName, title: regestration.title, description: "How do you want to connect?")
                .padding(.horizontal, 20)
                .padding(.bottom)
            VStack(spacing: 10) {
                OnBoardingImageButton(signMethod: .apple) {
                    print("apple sign in")
                }
                OnBoardingImageButton(signMethod: .google) {
                    print("google sign in")
                }
                OnBoardingButton(title: "Continue with an email") {
                    switch regestration {
                    case .signup:
                        coordinator.push {
                            SignupEmailView()
                        }
                    case .login:
                        coordinator.push {
                            LoginView()
                        }
                    }
                }
            }
        }
        .backButtonBar(title: regestration == .login ? "Enter" : "Create account") {
            coordinator.pop()
        }
    }
    
}

#Preview {
    SignView(regestration: .signup)
        .withNavigation()
}

#Preview {
    SignView(regestration: .login)
        .withNavigation()
}
