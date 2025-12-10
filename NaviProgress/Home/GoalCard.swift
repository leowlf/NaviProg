import SwiftUI

// MARK: - GoalCard Component

struct GoalCard: View {
    let title: String
    let percent: Double
    
    var body: some View {
        HStack {
            Text(title)
                .font(.headline)
            Spacer()
            Text("\(Int(percent * 100))%")
                .foregroundColor(.blue)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

