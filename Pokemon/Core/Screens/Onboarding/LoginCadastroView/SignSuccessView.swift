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
            case .signup: return "Welcome back, Trainer!"
            case .login:  return "Your account has been successfully created!"
            }
        }
        
        var description: String {
            switch self {
            case .signup: return "We hope you have had a long journey since you last visited us."
            case .login:  return "Welcome, Coach! We’re excited to follow your journey."
            }
        }
    }
    
    let signSuccessCases: SignSuccessCases
    
    var body: some View {
        VStack {
            OnBoardingStackView(imageName: signSuccessCases.imageString, title: signSuccessCases.title, description: signSuccessCases.description)
                .padding(.bottom, 30)
                OnBoardingButton(title: "Continue") {
                    print("work 1")
                }
        }
    }
}

#Preview {
    SignSuccessView(signSuccessCases: .signup)
}
