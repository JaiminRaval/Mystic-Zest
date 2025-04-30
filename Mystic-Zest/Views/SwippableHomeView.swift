//
//  SwippableHomeView.swift
//  Mystic-Zest
//
//  Created by Jaimin Raval on 15/04/25.
//

import SwiftUI

struct SwippableHomeView: View {
    // Array of colors to cycle through
        let colors: [Color] = [.red, .orange, .yellow, .green, .blue, .purple, .pink]
        
        // Track the current color index and drag offset
        @State private var colorIndex = 0
        @State private var dragOffset: CGFloat = 0
        @State private var previousOffset: CGFloat = 0
        @State private var isDragging = false
        
        var body: some View {
            ZStack {

                colors[colorIndex]
                    .ignoresSafeArea()
                    .animation(.spring(response: 0.4, dampingFraction: 0.8), value: colorIndex)

                if isDragging {
                    Color.white.opacity(0.2)
                        .ignoresSafeArea()
                        .scaleEffect(1.0 + abs(dragOffset) / 1000)
//                        .opacity(min(abs(dragOffset) / 200, 0.3))
                }
                
                VStack {
                    Spacer()
                    
                    Text("Swipe to change colors")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding(.bottom, 40)
                }
            }
            .gesture(
                DragGesture()
                    .onChanged { gesture in
                        isDragging = true
                        dragOffset = gesture.translation.width
                    }
                    .onEnded { gesture in
                        isDragging = false
                        let threshold: CGFloat = 100
                        
                        if dragOffset > threshold {

                            colorIndex = (colorIndex - 1 + colors.count) % colors.count
                        } else if dragOffset < -threshold {

                            colorIndex = (colorIndex + 1) % colors.count
                        }
                        
                        dragOffset = 0
                    }
            )
            .animation(.spring(response: 0.3, dampingFraction: 0.7), value: dragOffset)
            .animation(.easeOut(duration: 0.3), value: isDragging)
        }
}

#Preview {
    SwippableHomeView()
}
