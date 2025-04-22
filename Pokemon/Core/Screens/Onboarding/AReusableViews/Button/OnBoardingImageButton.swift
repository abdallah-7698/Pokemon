//
//  OnBoardingImageButton.swift
//  Pokemon
//
//  Created by name on 22/04/2025.
//

import SwiftUI

struct OnBoardingImageButton: View {
    
    enum SignMethod: String {
        case apple = "Apple"
        case google = "Google"
        
        var iamgeName: String {
            switch self {
            case .apple: return "appleLogo"
            case .google: return "googleLogo"
            }
        }
    }
    
    let signMethod: SignMethod
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Label("Continue with \(signMethod.rawValue)", image: signMethod.iamgeName)
                .font(.title3)
                .foregroundColor(.black)
                .frame(width: UIScreen.main.bounds.width/1.1, height: 60 )
                .overlay {
                    RoundedRectangle(cornerRadius: 40)
                        .stroke(lineWidth: 2)
                        .foregroundColor(.gray)
                        .opacity(0.3)
                }
        }
    }
}

#Preview {
    OnBoardingImageButton(signMethod: .google, action: {print("works")})
}
