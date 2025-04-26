//
//  SplashView.swift
//  Pokemon
//
//  Created by name on 21/04/2025.
//

import SwiftUI

struct SplashView: View {
    
    @EnvironmentObject private var coordinator: Coordinator
    
    @State private var hasFired = false
    
    
    var body: some View {
        ZStack {
            Color("splashColor")
            Image("Pokedex")
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width/1.4)
        }
        .ignoresSafeArea(.all)
        .onAppear {
            if !hasFired {
                hasFired = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        coordinator.push {
                            OnboardingDescriptionView()
                                .navigationBarBackButtonHidden()
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    SplashView()
        .withNavigation()
}
