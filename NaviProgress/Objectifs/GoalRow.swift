import SwiftUI

struct GoalRow: View {
    var goal: Goal
    
    var body: some View {
        HStack(alignment: .top, spacing: 16) {
            
            // ICONE
            Text(goal.icon)
                .font(.largeTitle)
                .frame(width: 50, height: 50)
                .background(Color.blue.opacity(0.15))
                .cornerRadius(12)
            
            VStack(alignment: .leading, spacing: 6) {
                
                // TITRE
                Text(goal.title)
                    .font(.headline)
                
                // SOUS-TITRE : objectif + unité
                Text("Objectif : \(formatTarget(goal.target)) \(goal.unit)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                // FRÉQUENCE (Quotidien, Hebdo…)
                Text("Fréquence : \(goal.frequency.rawValue)")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                // PROGRESSION
                VStack(alignment: .leading, spacing: 4) {
                    ProgressView(value: goal.progress)
                        .tint(.blue)
                    
                    Text("\(Int(goal.progress * 100))%")
                        .font(.caption2)
                        .foregroundColor(.blue)
                }
                .padding(.top, 6)
            }
            
            Spacer()
        }
        .padding(.vertical, 8)
    }
    
    /// Formatte les chiffres : 5 → 5, 5.0 → 5
    func formatTarget(_ value: Double) -> String {
        return value == floor(value) ? String(Int(value)) : String(value)
    }
}

