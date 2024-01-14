//
//  WeeklyAverages.swift
//  StepViewerLite
//
//  Created by Emily Schell on 1/13/24.
//

import Foundation

struct WeeklyAverages: Comparable {
    static func < (lhs: WeeklyAverages, rhs: WeeklyAverages) -> Bool {
        lhs.steps == rhs.steps &&
        lhs.distance == rhs.distance &&
        lhs.pace == rhs.pace &&
        lhs.floorsAscended == rhs.floorsAscended
    }
    
    var steps: Double
    var distance: Double
    var pace: Double
    var floorsAscended: Double
}
