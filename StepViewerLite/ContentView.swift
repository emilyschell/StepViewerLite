//
//  ContentView.swift
//  StepViewerLite
//
//  Created by Emily Schell on 1/12/24.
//

import SwiftUI
import CoreMotion

struct DailySteps {
    var date: Date
    var numberOfSteps: NSNumber
    var distance: NSNumber
    var averageActivePace: NSNumber
    var floorsAscended: NSNumber
}

struct ContentView: View {
    private let pedometer: CMPedometer = CMPedometer()
    
    private var isPedometerDataAvailable: Bool {
        return CMPedometer.isStepCountingAvailable() && CMPedometer.isDistanceAvailable() && CMPedometer.isFloorCountingAvailable() && CMPedometer.isPaceAvailable()
           }
    
    @State private var stepsData: [DailySteps] = []
    
    private func getStepsData() -> [DailySteps] {
        if isPedometerDataAvailable {
            var dataList: [DailySteps] = []
            for daysAgo in (0...7) {
                guard let queryStartDate = Calendar.current.date(byAdding: .day, value: -daysAgo, to: Date()) else { return [] }
                guard let queryEndDate = Calendar.current.date(byAdding: .day, value: 1, to: queryStartDate) else { return [] }
                
                pedometer.queryPedometerData(from: Calendar.current.startOfDay(for: queryStartDate), to: Calendar.current.startOfDay(for: queryEndDate)) { (data, error) in
                    
                    guard let dailyData = data, error == nil else { return }
                    
                    let dailySteps = DailySteps(
                        date: queryStartDate,
                        numberOfSteps: dailyData.numberOfSteps,
                        distance: dailyData.distance ?? 0,
                        averageActivePace: dailyData.averageActivePace ?? 0,
                        floorsAscended: dailyData.floorsAscended ?? 0
                    )
                    dataList.append(dailySteps)
                }
            }
            return dataList
        } else {
            // TODO: else load demo data to stepsData and show Toast Msg
            return []
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("This Week's Steps")
                    .font(.title)
                Image(systemName: "figure.walk")
                    .font(.title)
                Spacer()
            }
            .padding(.leading)
            List(stepsData, id: \.date) { dailyData in
                Text(String(describing: dailyData.date))
                Text(String(describing: dailyData.numberOfSteps))
                Image(systemName: "chevron.right")
//                NavigationLink(destination: DetailView()) {}
            }
            Spacer()
        }
        .padding()
        .onAppear() {
            self.stepsData = getStepsData()
        }
    }
}

#Preview {
    ContentView()
}
