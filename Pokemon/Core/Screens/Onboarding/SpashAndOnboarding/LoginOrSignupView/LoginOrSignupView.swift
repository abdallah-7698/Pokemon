//
//  LoginOrSignupView.swift
//  Pokemon
//
//  Created by name on 22/04/2025.
//

import SwiftUI

struct LoginOrSignupView: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("skip")
                    .font(.headline)
                Button {
                    // move to the main app
                } label: {
                    Image(systemName: "arrow.right")
                        .foregroundColor(.black)
                }
            }
            .padding(.trailing)
            OnBoardingStackView(
                imageName: "login-Cadastro",
                title: "Are you ready for this adventure?",
                description: "Simply create an account and start exploring the world of Pokémon today!")
            .padding(.bottom, 30)
            VStack(spacing: 0) {
                
                OnBoardingButton(title: "Create account") {
                    coordinator.push {
                        SignView(regestration: .signup)
                    }
                }
                
                OnBoardingButton(title: "I already have an account",
                                 textColor: Color("defaultLightBlue"),
                                 backgroundColor: .clear
                ) {
                    coordinator.push {
                        SignView(regestration: .login)
                    }
                }
            }
        }
        .ignoresSafeArea(.all)
        .offset(y: -20)
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    LoginOrSignupView()
        .withNavigation()
}
