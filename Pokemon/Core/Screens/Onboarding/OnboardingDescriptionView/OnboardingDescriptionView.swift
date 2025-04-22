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
    
    var body: some View {
        VStack(spacing: 30){
            TabView(selection: $currentIndex) {
                ForEach( OnboardingDescription.allCases.indices, id: \.self ) { index in
                    let onBoardingItem = OnboardingDescription.allCases[index]
                    VStack(spacing: 20) {
                        Image(onBoardingItem.imageName)
                            .resizable()
                            .scaledToFit()
                            .padding(.bottom, 20)
                        Text(onBoardingItem.title.capitalized)
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                            .multilineTextAlignment(.center)
                        Text(onBoardingItem.description.capitalized)
                            .font(.body)
                            .foregroundColor(.secondary)
                            .multilineTextAlignment(.center)
                            .frame(width: UIScreen.main.bounds.width * 0.8)
                    }
                    .tag(index)
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
            
            Button {
                withAnimation {
                    if currentIndex < 1 { currentIndex += 1 } else { /*login*/ }
                }
            } label: {
                Text(currentIndex < 1 ? "Next" : "Start")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width/1.3, height: 60 )
                    .background(Color("defaultLightBlue"))
                    .cornerRadius(40)
            }
            .buttonStyle(PlainButtonStyle())
        }
        .padding(.bottom, 20)
    }
}

#Preview {
    OnboardingDescriptionView()
}
