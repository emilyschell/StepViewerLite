//
//  DemoStepsData.swift
//  StepViewerLite
//
//  Created by Emily Schell on 1/13/24.
//

import Foundation

class DemoData: ObservableObject {
    @Published var demoStepsData = [DailyData]()
    
    init() {
        loadData()
    }
    
    func loadData() {
        guard let url = Bundle.main.url(forResource: "demoPedData", withExtension: "json")
            else {
                print("json file not found")
                return
            }
        
        guard let data = try? Data(contentsOf: url) else {
            print("unable to load \(url) from bundle")
            return
        }

        var demoStepsData = try? JSONDecoder().decode([DailyData].self, from: data)
        
        if demoStepsData != nil {
            for daysAgo in (0...6) {
                demoStepsData![daysAgo].date = Calendar.current.date(byAdding: .day, value: -daysAgo, to: Date()) ?? Date()
            }
        }
        
        self.demoStepsData = demoStepsData ?? []
    }
}
