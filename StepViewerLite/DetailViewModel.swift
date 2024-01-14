//
//  DetailViewModel.swift
//  StepViewerLite
//
//  Created by Emily Schell on 1/14/24.
//

import Foundation

class DetailViewModel: ObservableObject {
    func compareToAverage(metric: Double, average: Double) -> String {
        let aboveOrBelow = (metric - average) > 0 ? "above" : "below"
        let difference = String(format: "%.2f", abs(metric - average))
        return "\(difference) \(aboveOrBelow) this week's average"
    }
    
    func metersToMiles(distance: Double) -> Double {
        let distanceInMeters = Measurement(value: distance, unit: UnitLength.meters)
        return Double(distanceInMeters.converted(to: UnitLength.miles).value)
    }
    
    func secPerMeterToMPH(pace: Double) -> Double {
        return pace * 2.23694
    }
}
