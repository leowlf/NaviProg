//
//  Performance.swift
//  NaviProgress
//
//  Created by Wolff on 10/12/2025.
//
import Foundation

struct Performance: Identifiable, Codable {
    let id = UUID()
    let date: Date
    let value: Double
    let goalID: UUID
}

