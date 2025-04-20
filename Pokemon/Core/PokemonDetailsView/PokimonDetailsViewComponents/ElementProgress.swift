//
//  ElementProgress.swift
//  Pokemon
//
//  Created by name on 20/04/2025.
//

import SwiftUI

struct ElementProgress: View {
    
    let title: String
    let color: Color
    
    @Binding var progress: Float
    
    var body: some View {
        ProgressView(value: progress, total: 100) {
            Text(title.uppercased())
                .font(.footnote)
                .textCase(.uppercase)
                .foregroundColor(Color(.darkGray))
        }
        .progressViewStyle(BarProgressStyle(color: color, height: 9))
        .padding()
    }
    
}

#Preview {
    ElementProgress(title: "Title", color: .purple, progress: .constant(60))
}

struct BarProgressStyle: ProgressViewStyle {
    
    var color: Color
    var height: Double = 20.0
    var labelFontStyle: Font = .body
    
    func makeBody(configuration: Configuration) -> some View {
        
        let progress = configuration.fractionCompleted ?? 0.0
        
        GeometryReader { geometry in
            
            VStack(alignment: .leading) {
                
                configuration.label
                    .font(labelFontStyle)
                
                RoundedRectangle(cornerRadius: 10.0)
                    .fill(Color(uiColor: .systemGray5))
                    .frame(height: height)
                    .frame(width: geometry.size.width)
                    .overlay(alignment: .leading) {
                        RoundedRectangle(cornerRadius: 10.0)
                            .fill(color)
                            .frame(width: geometry.size.width * progress)
                            .overlay {
                                if let currentValueLabel = configuration.currentValueLabel {
                                    
                                    currentValueLabel
                                        .font(.headline)
                                        .foregroundColor(.white)
                                }
                            }
                    }
                
            }
            
        }
    }
}
