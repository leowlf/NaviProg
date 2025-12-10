//
//  Goal+Tracking.swift
//  NaviProgress
//
//  Created by Wolff on 10/12/2025.
//

import Foundation

extension Goal {
    /// Valeur réelle cumulée ou remplacée
    var progressValue: Double {
        get { storedProgressValue }
        set { storedProgressValue = newValue }
    }
}


