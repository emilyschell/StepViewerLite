//
//  DailyData.swift
//  StepViewerLite
//
//  Created by Emily Schell on 1/13/24.
//

import Foundation

struct DailyData: Codable, Hashable {
    
    enum CodingKeys: CodingKey {
        case numberOfSteps
        case distance
        case averageActivePace
        case floorsAscended
    }
    
    var date: Date? = Date()
    var numberOfSteps: Double
    var distance: Double
    var averageActivePace: Double
    var floorsAscended: Double
}
