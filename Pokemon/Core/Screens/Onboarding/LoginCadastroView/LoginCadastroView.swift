//
//  LoginCadastroView.swift
//  Pokemon
//
//  Created by name on 22/04/2025.
//

import SwiftUI

struct LoginCadastroView: View {
    var body: some View {
        VStack {
            OnBoardingStackView(imageName: "login-Cadastro", title: "Are you ready for this adventure?", description: "Simply create an account and start exploring the world of Pokémon today!")
                .padding(.bottom, 30)
            VStack(spacing: 0) {
                OnBoardingButton(title: "Create account") {
                    print("work 1")
                }
                OnBoardingButton(title: "I already have an account",
                                 textColor: Color("defaultLightBlue"),
                                 backgroundColor: .clear
                ) {
                    print("work 2")
                }
            }
        }
    }
}

#Preview {
    LoginCadastroView()
}
