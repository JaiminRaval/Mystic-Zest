//
//  SoothGradientView.swift
//  Mystic-Zest
//
//  Created by Jaimin Raval on 22/04/25.
//

import SwiftUI

struct SmoothGradientView: View {
    var colors: [Color]
        
    // Animation properties
    private let animationDuration: Double = 8.0
    private let movementScale: CGFloat = 0.2
    
    // State for animation
    @State private var phase: CGFloat = 0.0
    @State private var noiseScale: CGFloat = 25.0
    @State private var noisePhase: CGFloat = 0.0
    
    init(hexColors: [String]) {
        // Convert hex strings to Color objects
        self.colors = hexColors.map { Color(hex: $0) }
        }
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                // Updated MeshGradient with correct parameters
                
            }
            .onAppear {
                // Animated phase for smooth transitions
                withAnimation(
                    .easeInOut(duration: animationDuration)
                    .repeatForever(autoreverses: true)
                ) {
                    phase = 2 * .pi
                    noiseScale = 35.0
                }
            }
            
            
        }
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
