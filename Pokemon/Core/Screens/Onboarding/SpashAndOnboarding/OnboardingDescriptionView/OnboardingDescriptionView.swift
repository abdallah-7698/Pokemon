//
//  OnboardingAppDescription.swift
//  Pokemon
//
//  Created by name on 22/04/2025.
//

import SwiftUI

enum OnboardingDescription: CaseIterable {
    case onboarding1
    case onboarding2
    
    var imageName: String {
        switch self {
        case .onboarding1: return "onBoarding-1"
        case .onboarding2: return "onBoarding-2"
        }
    }
    
    var title: String {
        switch self {
        case .onboarding1: return "All Pokémons in One Place"
        case .onboarding2: return "Keep Your Pokédex Updated"
        }
    }
    
    var description: String {
        switch self {
        case .onboarding1: return "Access a vast list of Pokémon from all generations ever created by Nintendo."
        case .onboarding2: return "Sign up and keep your profile, favorite Pokémon, settings, and much more saved in the app — even without an internet connection."
        }
    }
}

struct OnboardingDescriptionView: View {
    @State private var currentIndex: Int = 0
    
    @EnvironmentObject private var coordinator: Coordinator
    
    var body: some View {
        VStack(spacing: 30){
            TabView(selection: $currentIndex) {
                ForEach( OnboardingDescription.allCases.indices, id: \.self ) { index in
                    let onBoardingItem = OnboardingDescription.allCases[index]
                    OnBoardingStackView(
                        imageName: onBoardingItem.imageName,
                        title: onBoardingItem.title,
                        description: onBoardingItem.description
                    ).tag(index)
                }
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
            
            HStack {
                ForEach( OnboardingDescription.allCases.indices, id: \.self ) { index in
                    if index == currentIndex {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 20, height: 10)
                            .foregroundColor(Color("defaultLightBlue"))
                    } else {
                        Circle()
                            .frame(width: 10, height: 10)
                            .foregroundColor(.gray)
                    }
                }
            }
            
            OnBoardingButton(title: currentIndex < 1 ? "Next" : "Start") {
                withAnimation {
                    if currentIndex < 1 { currentIndex += 1 } else { coordinator.push {
                        LoginOrSignupView()
                    } }
                }
            }.buttonStyle(PlainButtonStyle())
        }
        .padding(.bottom, 20)
    }
}

#Preview {
    OnboardingDescriptionView()
        .withNavigation()
}
