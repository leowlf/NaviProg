import SwiftUI

struct AvatarCommentBubble: View {
    var message: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 6) {
            
            // petite flèche
            Triangle()
                .fill(.ultraThinMaterial)
                .frame(width: 12, height: 12)
                .rotationEffect(.degrees(45))
                .offset(x: 6, y: 10)
            
            // bulle
            Text(message)
                .font(.subheadline)
                .padding(12)
                .background(.ultraThinMaterial)
                .cornerRadius(14)
                .shadow(color: .black.opacity(0.15), radius: 3)
        }
    }
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var p = Path()
        p.move(to: CGPoint(x: rect.midX, y: rect.minY))
        p.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        p.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        p.closeSubpath()
        return p
    }
}

//
//  AvatarCommentBubble.swift
//  NaviProgress
//
//  Created by Wolff on 10/12/2025.
//

