//
//  StatBlock.swift
//  Pokemon
//
//  Created by name on 20/04/2025.
//

import SwiftUI

struct StatBlock: View {
    let icon: String
    let label: String
    let value: String
    
    private let screenWidth: CGFloat = UIScreen.main.bounds.width
    
    var body: some View {
        VStack(alignment: .leading,spacing: 4) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(.gray)
                    .imageScale(.medium)
                Text(label)
                    .font(.footnote)
                    .textCase(.uppercase)
                    .foregroundColor(.secondary)
            }
            Text(value)
                .font(.headline)
                .fontWeight(.bold)
                .padding()
                .frame(width: screenWidth/2.4, height: 50)
                .overlay {
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(lineWidth: 1)
                        .foregroundColor(.secondary)
                        .opacity(0.3)
                }
        }
    }
}

#Preview {
    StatBlock(icon: "person", label: "exp", value: "50 Point")
}
