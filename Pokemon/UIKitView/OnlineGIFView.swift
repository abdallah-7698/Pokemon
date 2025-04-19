//
//  OnlineGIFView.swift
//  Pokemon
//
//  Created by name on 19/04/2025.
//

import SwiftUI
import UIKit

struct OnlineGIFView: UIViewRepresentable {
    let gifURL: URL

    func makeUIView(context: Context) -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        loadGIF(from: gifURL, into: imageView)
        return imageView
    }

    func updateUIView(_ uiView: UIImageView, context: Context) {}

    private func loadGIF(from url: URL, into imageView: UIImageView) {
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url),
               let animatedImage = UIImage.gif(data: data) {
                DispatchQueue.main.async {
                    imageView.image = animatedImage
                }
            }
        }
    }
}

extension UIImage {
    static func gif(data: Data) -> UIImage? {
        guard let source = CGImageSourceCreateWithData(data as CFData, nil) else { return nil }
        var images = [UIImage]()
        var duration: TimeInterval = 0

        let count = CGImageSourceGetCount(source)
        for i in 0..<count {
            if let cgImage = CGImageSourceCreateImageAtIndex(source, i, nil) {
                images.append(UIImage(cgImage: cgImage))
            }
            let frameDuration = UIImage.frameDuration(for: source, at: i)
            duration += frameDuration
        }

        return UIImage.animatedImage(with: images, duration: duration)
    }

    static func frameDuration(for source: CGImageSource, at index: Int) -> TimeInterval {
        var frameDuration: TimeInterval = 0.1
        let properties = CGImageSourceCopyPropertiesAtIndex(source, index, nil) as? [CFString: Any]
        let gifProperties = properties?[kCGImagePropertyGIFDictionary] as? [CFString: Any]
        if let delayTime = gifProperties?[kCGImagePropertyGIFUnclampedDelayTime] as? TimeInterval {
            frameDuration = delayTime
        } else if let delayTime = gifProperties?[kCGImagePropertyGIFDelayTime] as? TimeInterval {
            frameDuration = delayTime
        }
        return max(frameDuration, 0.02) // Ensure a minimum frame duration
    }
}

struct ContentView: View {
    var body: some View {
        OnlineGIFView(gifURL: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-v/black-white/animated/6.gif")!)
            .frame(width: 230, height: 260)
            .border(Color.blue, width: 4)
    }
}

// Preview for SwiftUI
struct OnlineGIFView_Previews: PreviewProvider {
    static var previews: some View {
        OnlineGIFView(
            gifURL: URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-v/black-white/animated/6.gif")!
        )
        .frame(width: 230, height: 260)
        .border(Color.blue, width: 4)
    }
}
