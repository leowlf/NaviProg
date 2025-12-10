import SwiftUI

// MARK: - HomeSection Component

struct HomeSection: View {
    let title: String
    let progress: Double
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.title2.bold())
            ProgressView(value: progress)
                .tint(color)
            Text("\(Int(progress * 100))%")
                .font(.headline)
                .foregroundColor(color)
        }
    }
}

