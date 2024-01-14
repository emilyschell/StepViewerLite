//
//  DetailView.swift
//  StepViewerLite
//
//  Created by Emily Schell on 1/13/24.
//

import SwiftUI

struct DetailView: View {
    private var stepsData: [DailyData]
    private var selectedIndex: Int
    private var weeklyAverages: WeeklyAverages
    
    init(stepsData: [DailyData], selectedIndex: Int) {
        self.stepsData = stepsData
        self.selectedIndex = selectedIndex
        
        var totalSteps: Double = 0
        var totalDistance: Double = 0
        var totalPace: Double = 0
        var totalFloors: Double = 0
        
        for day in stepsData {
            totalSteps += day.numberOfSteps
            totalDistance += day.distance
            totalPace += day.averageActivePace
            totalFloors += day.floorsAscended
        }
            
        self.weeklyAverages = WeeklyAverages(
                steps: totalSteps / 7,
                distance: totalDistance / 7,
                pace: totalPace / 7,
                floorsAscended: totalFloors / 7
            )
    }
    
    private func compareToAverage(metric: Double, average: Double) -> String {
        let aboveOrBelow = (metric - average) > 0 ? "above" : "below"
        let difference = String(format: "%.2f", abs(metric - average))
        return "\(difference) \(aboveOrBelow) this week's average"
    }
    
    private func metersToMiles(distance: Double) -> Double {
        let distanceInMeters = Measurement(value: distance, unit: UnitLength.meters)
        return Double(distanceInMeters.converted(to: UnitLength.miles).value)
    }
    
    private func secPerMeterToMPH(pace: Double) -> Double {
        return pace * 2.23694
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(stepsData[selectedIndex].date ?? Date(), format: .dateTime.weekday().month().day())
                    .font(.title)
                Spacer()
            }
            .padding(.leading)
            
            HStack {
                Image(systemName: "shoe")
                    .font(.title)
                    .foregroundColor(.blue)
                    .padding(.leading)
                VStack {
                    HStack {
                        Text("Daily steps: \(String(format: "%.0f", stepsData[selectedIndex].numberOfSteps))")
                            .font(.headline)
                        Spacer()
                    }
                    HStack {
                        Text(compareToAverage(metric: stepsData[selectedIndex].numberOfSteps, average: weeklyAverages.steps))
                        Spacer()
                    }
                }
                .padding()
            }
            .background(RoundedRectangle(cornerRadius: 15)
                .foregroundColor(Color(.systemGroupedBackground)).shadow(color: .black, radius: 3))
            .padding(.vertical)
            
            HStack {
                Image(systemName: "figure.stairs")
                    .font(.title)
                    .foregroundColor(.blue)
                    .padding(.leading)
                VStack {
                    HStack {
                        Text("Flights climbed: \(String(format: "%.0f", stepsData[selectedIndex].floorsAscended))")
                            .font(.headline)
                        Spacer()
                    }
                    HStack {
                        Text(compareToAverage(metric: stepsData[selectedIndex].floorsAscended, average: weeklyAverages.floorsAscended))
                        Spacer()
                    }
                }
                .padding()
            }
            .background(RoundedRectangle(cornerRadius: 15)
                .foregroundColor(Color(.systemGroupedBackground)).shadow(color: .black, radius: 3))
            .padding(.vertical)

            HStack {
                Image(systemName: "road.lanes")
                    .font(.title)
                    .foregroundColor(.blue)
                    .padding(.leading)
                VStack {
                    HStack {
                        Text("Distance: \(String(format: "%.1f", metersToMiles(distance: stepsData[selectedIndex].distance))) mi")
                            .font(.headline)
                        Spacer()
                    }
                    HStack {
                        Text(compareToAverage(metric: metersToMiles(distance: stepsData[selectedIndex].distance), average: metersToMiles(distance: weeklyAverages.distance)))
                        Spacer()
                    }
                }
                .padding()
            }
            .background(RoundedRectangle(cornerRadius: 15)
                .foregroundColor(Color(.systemGroupedBackground)).shadow(color: .black, radius: 3))
            .padding(.vertical)
            
            HStack {
                Image(systemName: "stopwatch")
                    .font(.title)
                    .foregroundColor(.blue)
                    .padding(.leading)
                VStack {
                    HStack {
                        Text("Average pace: \(String(format: "%.1f", secPerMeterToMPH(pace: stepsData[selectedIndex].averageActivePace))) mph")
                            .font(.headline)
                        Spacer()
                    }
                    HStack {
                        Text(compareToAverage(metric: secPerMeterToMPH(pace: stepsData[selectedIndex].averageActivePace), average: secPerMeterToMPH(pace: weeklyAverages.pace)))
                        Spacer()
                    }
                    Spacer()
                }
                .padding()
            }
            .background(RoundedRectangle(cornerRadius: 15)
                .foregroundColor(Color(.systemGroupedBackground)).shadow(color: .black, radius: 3))
            .padding(.vertical)
            .fixedSize(horizontal: false, vertical: true)
            
            Spacer()
        }
        .padding(.horizontal)
    }
}

#Preview {
    DetailView(stepsData: DemoData().demoStepsData, selectedIndex: 0)
}
