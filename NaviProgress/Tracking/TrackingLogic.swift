//
//  TrackingLogic.swift
//  NaviProgress
//

import Foundation

struct TrackingLogic {

    /// Calcule la nouvelle valeur de progression en fonction du type et de la fréquence
    static func updateProgress(for goal: Goal, with input: Double) -> Double {

        switch goal.frequency {

        case .quotidien:
            // Valeur REMPLACÉE chaque jour
            return min(input / goal.target, 1.0)

        case .hebdomadaire:
            // Valeur CUMULÉE dans la semaine
            let newValue = goal.storedProgressValue + input
            return min(newValue / goal.target, 1.0)

        case .mensuel:
            // Valeur CUMULÉE dans le mois
            let newValue = goal.storedProgressValue + input
            return min(newValue / goal.target, 1.0)

        case .annuel:
            // Valeur CUMULÉE dans l'année
            let newValue = goal.storedProgressValue + input
            return min(newValue / goal.target, 1.0)

        case .unique:
            // Objectif ponctuel → progression cumulée
            let newValue = goal.storedProgressValue + input
            return min(newValue / goal.target, 1.0)
        }
    }
}

