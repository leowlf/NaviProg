//
//  TrackingLogic.swift
//  NaviProgress
//
//  Created by Wolff on 10/12/2025.
//
import Foundation

func updateGoalProgress(goal: inout Goal, value: Double) {
    
    switch goal.frequency {

    case .quotidien:
        switch goal.type {
        case .habitude:
            // habitude = booléen → 1 = fait / 0 = pas fait
            goal.progressValue = value

        case .duree, .quantite:
            // on cumule (permet de "gratter" la journée)
            goal.progressValue += value

        default:
            goal.progressValue = value
        }

    case .hebdomadaire, .mensuel:
        // cumuls
        goal.progressValue += value

    case .unique:
        // remplace
        goal.progressValue = value
    }

    // Mise à jour du pourcentage ✔
    goal.progress = min(goal.progressValue / goal.target, 1.0)
}

