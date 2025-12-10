import Foundation

enum GoalType: String, Codable, CaseIterable {
    case quantite = "Quantité"
    case duree = "Durée"
    case repetition = "Répétitions"
    case financier = "Financier"
    case habitude = "Habitude"
}

enum GoalFrequency: String, Codable, CaseIterable {
    case quotidien = "Quotidien"
    case hebdomadaire = "Hebdomadaire"
    case mensuel = "Mensuel"
    case unique = "Unique"
}

struct Goal: Identifiable, Codable {
    let id: UUID
    
    var title: String
    var icon: String
    var type: GoalType
    var target: Double
    var unit: String
    var frequency: GoalFrequency
    
    var progress: Double
    var storedProgressValue: Double
    
    // ⭐ L'INITIALISEUR MANQUANT
    init(
        id: UUID = UUID(),
        title: String,
        icon: String,
        type: GoalType,
        target: Double,
        unit: String,
        frequency: GoalFrequency,
        progress: Double = 0.0,
        storedProgressValue: Double = 0.0
    ) {
        self.id = id
        self.title = title
        self.icon = icon
        self.type = type
        self.target = target
        self.unit = unit
        self.frequency = frequency
        self.progress = progress
        self.storedProgressValue = storedProgressValue
    }
}

