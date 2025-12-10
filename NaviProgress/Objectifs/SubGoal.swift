import Foundation

struct SubGoal: Identifiable, Codable {
    var id = UUID()
    
    var title: String
    var target: Double
    var progress: Double
    var unit: String
    var frequency: GoalFrequency
}

