//
//  ContentView.swift
//  StepViewerLite
//
//  Created by Emily Schell on 1/12/24.
//

import SwiftUI
import CoreMotion

struct WeeklyView: View {
    private let pedometer: CMPedometer = CMPedometer()
    @ObservedObject var demoData = DemoData()
    
    private var isPedometerDataAvailable: Bool {
        return CMPedometer.isStepCountingAvailable() && CMPedometer.isDistanceAvailable() && CMPedometer.isFloorCountingAvailable() && CMPedometer.isPaceAvailable()
    }
    
    @State private var stepsData: [DailyData] = [DailyData]()
    
    private func queryPedometer() {
        for daysAgo in (0...6) {
            guard let queryStartDate = Calendar.current.date(byAdding: .day, value: -daysAgo, to: Date()) else { return }
            guard let queryEndDate = Calendar.current.date(byAdding: .day, value: 1, to: queryStartDate) else { return }
            
            pedometer.queryPedometerData(from: Calendar.current.startOfDay(for: queryStartDate), to: Calendar.current.startOfDay(for: queryEndDate)) { (data, error) in
                
                guard let dailyData = data, error == nil else { return }
                
                let dailySteps = DailyData(
                    date: queryStartDate,
                    numberOfSteps: Double(truncating: dailyData.numberOfSteps),
                    distance: Double(truncating: dailyData.distance ?? 0),
                    averageActivePace: Double(truncating: dailyData.averageActivePace ?? 0),
                    floorsAscended: Double(truncating: dailyData.floorsAscended ?? 0)
                )
                stepsData.append(dailySteps)
            }
        }
    }
    
    private func showDemoData() {
        // TODO: show Toast Msg
        stepsData = demoData.demoStepsData
    }
    
    private func getSteps() {
        if isPedometerDataAvailable {
            queryPedometer()
        } else {
            showDemoData()
        }
    }
    
    var body: some View {
        NavigationView {
            NavigationStack {
                HStack {
                    Text("This week's steps")
                        .font(.title)
                    Image(systemName: "figure.walk")
                        .font(.title)
                    Spacer()
                }
                .padding()

                List {
                    ForEach(Array(stepsData.enumerated()), id: \.element.date) { (index, dailyData) in
                        NavigationLink {
                            DetailView(stepsData: stepsData, selectedIndex: index)
                        } label: {
                            HStack {
                                Text(dailyData.date ?? Date(), format: .dateTime.weekday())
                                    .font(.headline)
                                Spacer()
                                Text(dailyData.numberOfSteps, format: .number)
                                    .font(.title2)
                                    .padding(.trailing)
                            }
                            .padding()
                        }
                    }
                }
            }
        }
        .onAppear() {
            getSteps()
        }
    }
}

#Preview {
    WeeklyView()
}
