import Foundation

struct Goal: Identifiable, Codable {
    var id = UUID()
    
    var title: String
    var icon: String
    var type: GoalType
    var target: Double
    var unit: String
    var frequency: GoalFrequency
    
    // Valeur cumulée ou saisie
    var storedProgressValue: Double
    
    // Progression affichée (0 → 1)
    var progress: Double
    
    // Sous-objectifs
    var subGoals: [SubGoal] = []
    
    // Calcul automatique si besoin
    var computedProgress: Double {
        if target == 0 { return 0 }
        return storedProgressValue / target
    }
}

