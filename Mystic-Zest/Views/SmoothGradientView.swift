//
//  SoothGradientView.swift
//  Mystic-Zest
//
//  Created by Jaimin Raval on 22/04/25.
//

import SwiftUI

struct SmoothGradientView: View {
    var colors: [Color]
        
    @State var t: Float = 0.0
    @State var timer: Timer?
    
    init(hexColors: [String]) {
        // Convert hex strings to Color objects
        self.colors = hexColors.map { Color(hex: $0) }
        }
    var body: some View {
        ZStack {
            if #available(iOS 18.0, *) {
                MeshGradient(width: 3, height: 3, points: [
                    .init(0, 0), .init(0.5, 0), .init(1, 0),
                    
                    [sinInRange(-0.8...(-0.2), offset: 0.439, timeScale: 0.342, t: t),
                     sinInRange(0.3...0.7, offset: 3.42, timeScale: 0.984, t: t)],
                    [sinInRange(0.1...0.8, offset: 0.239, timeScale: 0.084, t: t),
                     sinInRange(0.2...0.8, offset: 5.21, timeScale: 0.242, t: t)],
                    [sinInRange(1.0...1.5, offset: 0.939, timeScale: 0.084, t: t),
                     sinInRange(0.4...0.8, offset: 0.25, timeScale: 0.642, t: t)],
                    [sinInRange(-0.8...0.0, offset: 1.439, timeScale: 0.442, t: t),
                     sinInRange(1.4...1.9, offset: 3.42, timeScale: 0.984, t: t)],
                    [sinInRange(0.3...0.6, offset: 0.339, timeScale: 0.784, t: t),
                     sinInRange(1.0...1.2, offset: 1.22, timeScale: 0.772, t: t)],
                    [sinInRange(1.0...1.5, offset: 0.939, timeScale: 0.056, t: t),
                     sinInRange(1.3...1.7, offset: 0.47, timeScale: 0.342, t: t)]
                ], colors: [
                    .red, .purple, .indigo,
                    .orange, .white, .blue,
                    .orange, .black, .mint
                ])
                .onAppear {
                    timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
                        t += 0.02
                    }
                }
                .background(.black)
                .ignoresSafeArea()
            } else {
                // Fallback on earlier versions
            }
            
            
        }
    }
    func sinInRange(_ range: ClosedRange<Float>, offset: Float, timeScale: Float, t: Float) -> Float {
        let amplitude = (range.upperBound - range.lowerBound) / 2
        let midPoint = (range.upperBound + range.lowerBound) / 2
        return midPoint + amplitude * sin(timeScale * t + offset)
    }
}

#Preview {
    SmoothGradientView(hexColors: ["7F5AF0", // Purple
                                   "4EA8DE", // Blue
                                   "2CB67D", // Teal
                                   "FB5607"  // Orange
                               ])
}


extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
