//
//  SplashView.swift
//  Pokemon
//
//  Created by name on 21/04/2025.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            Color("splashColor")
            Image("Pokedex")
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width/1.4)
        }
        .ignoresSafeArea(.all)
    }
}

#Preview {
    SplashView()
}
