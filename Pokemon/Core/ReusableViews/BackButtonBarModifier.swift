//
//  BackButtonBarModifier.swift
//  Pokemon
//
//  Created by name on 26/04/2025.
//


import SwiftUI

struct BackButtonBarModifier: ViewModifier {
    let title: String
    let backAction: () -> Void

    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack(alignment: .center) {
                        Button(action: backAction) {
                            Image(systemName: "chevron.left")
                                .foregroundColor(.black)
                        }
                        Spacer()
                    }
                    .padding()
                    .frame(width: UIScreen.main.bounds.width)
                    .overlay {
                        Text(title)
                            .font(.title2)
                            .fontWeight(.bold)
                    }
                }
                
            }
    }
}

extension View {
    func backButtonBar(title: String, backAction: @escaping () -> Void) -> some View {
        self.modifier(BackButtonBarModifier(title: title, backAction: backAction))
    }
}
