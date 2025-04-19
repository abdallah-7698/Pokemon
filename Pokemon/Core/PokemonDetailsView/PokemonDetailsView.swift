//
//  PokemonDetailsView.swift
//  Pokemon
//
//  Created by name on 19/04/2025.
//

import SwiftUI

struct PokemonDetailsView: View {
    
    private let screenWidth: CGFloat = UIScreen.main.bounds.width
    private let topCircleHeight: CGFloat = UIScreen.main.bounds.width*1.7
    private let imageURL: String = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-v/black-white/animated/4.gif"
    private let monsterName: String = "Pikachu"
    private let monsterNumber: String = "1"
    
    private let elements: [PokemonElement] = [.fire, .grass]
    
    
    @State private var progress: Float = 20

    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    TopElementView(height: topCircleHeight, elementImage: elements.first!.imageName, elementColor: elements.first!.color)
                        .overlay(alignment: .bottom) {
                            GifImageMonster(url: imageURL)
                        }
                        .padding(.bottom)
                    
                    VStack {
                        Text(monsterName.capitalized)
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                        
                        Text("Nº\(formatNumber(Int(monsterNumber)))")
                            .fontWeight(.medium)
                            .foregroundStyle(.secondary)
                    }
                    .padding([.leading, .top])
                    .frame(width: screenWidth, alignment: .leading)
                    
                    HStack {
                        ForEach(elements, id: \.self) { element in
                            ElementFullView(imageName: element.imageName, color: element.color, title: element.rawValue.capitalized)
                        }
                    }
                    .padding(.leading)
                    .frame(width: screenWidth, alignment: .leading)
                    
                    Divider()
                        .padding()
                    
                    // MARK: - Stats
                    VStack(spacing: 13) {
                        HStack(spacing: 20) {
                            StatBlock(icon: "scalemass", label: "Weight", value: "6.9 kg")
                            StatBlock(icon: "ruler", label: "Height", value: "0.7 m")
                        }
                        
                        HStack(spacing: 20) {
                            StatBlock(icon: "leaf", label: "EXP", value: "128 EXP")
                            StatBlock(icon: "bolt.fill", label: "Ability", value: "Overgrow")
                        }
                        .padding(.bottom)
                                            
                    }
                    .frame(width: screenWidth)
                    
                    Divider()
                        .padding(.top)
                    
                    VStack(spacing: 5) {
                    ElementProgress(title: "HP", color: elements.first!.color, progress: $progress)
                    ElementProgress(title: "HP", color: elements.first!.color, progress: $progress)
                    ElementProgress(title: "HP", color: elements.first!.color, progress: $progress)
                    ElementProgress(title: "HP", color: elements.first!.color, progress: $progress)
                    ElementProgress(title: "HP", color: elements.first!.color, progress: $progress)
                    ElementProgress(title: "HP", color: elements.first!.color, progress: $progress)
                        Spacer()
                    }
                    .padding(.horizontal)
                    .frame(width: screenWidth)
                        
                    Divider()
                        .padding()
                    
                    EvolutionsView()
                    
                }
            }
            .edgesIgnoringSafeArea(.top)
            
        }
    }
    
    private  func formatNumber(_ number: Int?) -> String {
        guard let number = number else {
            return "000" // Placeholder for nil
        }
        return number <= 999 ? String(format: "%03d", number) : "\(number)"
    }
}

#Preview {
    PokemonDetailsView()
    
}

// reusable components

struct ElementProgress: View {
    
    let title: String
    let color: Color
    
    @Binding var progress: Float
    
    var body: some View {
        ProgressView(value: progress, total: 100) {
            Text("title".uppercased())
                .font(.footnote)
                .textCase(.uppercase)
                .foregroundColor(Color(.darkGray))
               }
        .progressViewStyle(BarProgressStyle(color: color, height: 9))
               .padding()
    }
    
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


struct TopElementView: View {
    
    let height: CGFloat
    let elementImage: String
    let elementColor: Color
    
    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0.0, to: 0.5)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [elementColor.opacity(1), elementColor.opacity(0.3)]),
                        startPoint: .center,
                        endPoint: .bottom
                    )
                )
                .frame(width: height, height: height)
                .offset(y: -height / 4)
            
            Image(elementImage)
                .resizable()
                .renderingMode(.template)
                .scaledToFit()
                .frame(width: 180)
                .foregroundColor(.clear)
                .overlay(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.white.opacity(1), Color.white.opacity(0.2)]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .mask(
                        Image(elementImage)
                            .resizable()
                            .scaledToFit()
                    )
                )
                .offset(y: 40)
        }
        .frame(height: height / 2)
        .padding(.bottom, 20)
    }
}

struct GifImageMonster: View {
    
    let url: String?
    
    var body: some View {
        if let stringURL = url, let URL = URL(string: stringURL) {
            OnlineGIFView(gifURL: URL)
                .scaledToFill()
                .frame(width: 180, height: 200)
                .padding(.bottom, -20)
        } else {
            PokemonMonsterImage(url: url)
        }
    }
}

struct ElementFullView: View {
    let imageName: String
    let color: Color
    let title: String
    
    var body: some View {
        HStack {
            ZStack {
                Circle()
                    .fill(.white)
                    .frame(width: 35, height: 35)
                
                Image(imageName)
                    .resizable()
                    .renderingMode(.template)
                    .scaledToFit()
                    .foregroundColor(color)
                    .frame(width: 20)
            }
            Text(title)
        }
        .padding(.vertical, 6)
        .padding(.horizontal, 12)
        .background(color)
        .cornerRadius(20)
        
    }
}
