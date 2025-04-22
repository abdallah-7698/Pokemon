//
//  OnBoardingButton.swift
//  Pokemon
//
//  Created by name on 22/04/2025.
//

import SwiftUI

struct OnBoardingButton: View {
    var title: LocalizedStringKey
    
    // design
    var textColor: Color = .white
    var backgroundColor: Color = Color("defaultLightBlue") 
    
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(textColor)
                .frame(width: UIScreen.main.bounds.width/1.1, height: 60 )
                .background(backgroundColor)
                .cornerRadius(40)
        }
    }
}

#Preview {
    OnBoardingButton(title: "Click Me", action: {
        print("Button tapped!")
    })
    .preferredColorScheme(.dark)
}

