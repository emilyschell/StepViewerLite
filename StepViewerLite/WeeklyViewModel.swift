//
//  WeeklyViewModel.swift
//  StepViewerLite
//
//  Created by Emily Schell on 1/14/24.
//

import Foundation
import CoreMotion

class WeeklyViewModel: ObservableObject {
    private let pedometer: CMPedometer = CMPedometer()
    var demoData = DemoData()
    @Published var usingDemoData: Bool = false
    @Published var stepsData: [DailyData] = [DailyData]()
    
    private var isPedometerDataAvailable: Bool {
        return CMPedometer.isStepCountingAvailable() && CMPedometer.isDistanceAvailable() && CMPedometer.isFloorCountingAvailable() && CMPedometer.isPaceAvailable()
    }
    
    private func queryPedometer() {
        for daysAgo in (0...6) {
            guard let queryStartDate = Calendar.current.date(byAdding: .day, value: -daysAgo, to: Date()) else { return }
            guard let queryEndDate = Calendar.current.date(byAdding: .day, value: 1, to: queryStartDate) else { return }
            
            pedometer.queryPedometerData(from: Calendar.current.startOfDay(for: queryStartDate), to: Calendar.current.startOfDay(for: queryEndDate)) { (data, error) in
                DispatchQueue.main.async {

                    guard let dailyData = data, error == nil else { return }

                    let dailySteps = DailyData(
                        date: queryStartDate,
                        numberOfSteps: Double(truncating: dailyData.numberOfSteps),
                        distance: Double(truncating: dailyData.distance ?? 0),
                        averageActivePace: Double(truncating: dailyData.averageActivePace ?? 0),
                        floorsAscended: Double(truncating: dailyData.floorsAscended ?? 0)
                    )
                    self.stepsData.append(dailySteps)
                }
            }
        }
    }
    
    private func showDemoData() {
        self.stepsData = demoData.demoStepsData
    }
    
    func getSteps() {
        if isPedometerDataAvailable {
            queryPedometer()
        } else {
            self.usingDemoData = true
            showDemoData()
        }
    }
}
